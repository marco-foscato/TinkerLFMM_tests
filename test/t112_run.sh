#\!/bin/sh
# Test for TinkerLFMM: Test 112
 
rm -f lfse.in
echo " Test 112: Geometry Optimization" 
cp input/t112.xyz input/t112.key input/t112_optDM.xyz .
"$TINKERLFMMBIN"/minimize t112.xyz 0.01  > t112.log
if [ ! -f t112.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t112.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t112.xyz_2 t112_optTnk.xyz
cp t112.key t112_optTnk.key
"$TINKERLFMMBIN"/analyze t112_optTnk.xyz es >> t112.log
if [ ! -f t112.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t112.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t112 t112.log results_DommiMOE2011/t112_DommiMOE-OPT.log)
echo 112 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t112 t112.log results_DommiMOE2011/t112_DommiMOE-OPT.log)
echo 112 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t112_optDM.xyz t112_optTnk.key t112_optTnk.xyz 1 y u n 0.0 >> t112.log
result=$(grep "Root Mean Square Distance" t112.log -m1 | awk {'print $6'})
echo 112 t112 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t112.log t112_optTnk.xyz results_TinkerLFMM/
rm t112.xyz t112_optTnk.key t112.key t112_optDM.xyz 
echo " Test 112: completed" 
