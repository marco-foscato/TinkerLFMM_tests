#\!/bin/sh
# Test for TinkerLFMM: Test 103
 
rm -f lfse.in
echo " Test 103: Geometry Optimization" 
cp input/t103.xyz input/t103.key input/t103_optDM.xyz .
"$TINKERLFMMBIN"/minimize t103.xyz 0.01  > t103.log
if [ ! -f t103.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t103.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t103.xyz_2 t103_optTnk.xyz
cp t103.key t103_optTnk.key
"$TINKERLFMMBIN"/analyze t103_optTnk.xyz es >> t103.log
if [ ! -f t103.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t103.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t103 t103.log results_DommiMOE2011/t103_DommiMOE-OPT.log)
echo 103 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t103 t103.log results_DommiMOE2011/t103_DommiMOE-OPT.log)
echo 103 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t103_optDM.xyz t103_optTnk.key t103_optTnk.xyz 1 y u n 0.0 >> t103.log
result=$(grep "Root Mean Square Distance" t103.log -m1 | awk {'print $6'})
echo 103 t103 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t103.log t103_optTnk.xyz results_TinkerLFMM/
rm t103.xyz t103_optTnk.key t103.key t103_optDM.xyz 
echo " Test 103: completed" 
