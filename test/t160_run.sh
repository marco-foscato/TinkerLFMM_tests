#\!/bin/sh
# Test for TinkerLFMM: Test 160
 
rm -f lfse.in
echo " Test 160: Geometry Optimization" 
cp input/t160.xyz input/t160.key input/t160_optDM.xyz .
"$TINKERLFMMBIN"/minimize t160.xyz 0.01  > t160.log
if [ ! -f t160.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t160.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t160.xyz_2 t160_optTnk.xyz
cp t160.key t160_optTnk.key
"$TINKERLFMMBIN"/analyze t160_optTnk.xyz es >> t160.log
if [ ! -f t160.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t160.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t160 t160.log results_DommiMOE2011/t160_DommiMOE-OPT.log)
echo 160 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t160 t160.log results_DommiMOE2011/t160_DommiMOE-OPT.log)
echo 160 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t160_optDM.xyz t160_optTnk.key t160_optTnk.xyz 1 y u n 0.0 >> t160.log
result=$(grep "Root Mean Square Distance" t160.log -m1 | awk {'print $6'})
echo 160 t160 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t160.log t160_optTnk.xyz results_TinkerLFMM/
rm t160.xyz t160_optTnk.key t160.key t160_optDM.xyz 
echo " Test 160: completed" 
