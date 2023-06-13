#\!/bin/sh
# Test for TinkerLFMM: Test 132
 
rm -f lfse.in
echo " Test 132: Geometry Optimization" 
cp input/t132.xyz input/t132.key input/t132_optDM.xyz .
"$TINKERLFMMBIN"/minimize t132.xyz 0.01  > t132.log
if [ ! -f t132.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t132.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t132.xyz_2 t132_optTnk.xyz
cp t132.key t132_optTnk.key
"$TINKERLFMMBIN"/analyze t132_optTnk.xyz es >> t132.log
if [ ! -f t132.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t132.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t132 t132.log results_DommiMOE2011/t132_DommiMOE-OPT.log)
echo 132 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t132 t132.log results_DommiMOE2011/t132_DommiMOE-OPT.log)
echo 132 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t132_optDM.xyz t132_optTnk.key t132_optTnk.xyz 1 y u n 0.0 >> t132.log
result=$(grep "Root Mean Square Distance" t132.log -m1 | awk {'print $6'})
echo 132 t132 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t132.log t132_optTnk.xyz results_TinkerLFMM/
rm t132.xyz t132_optTnk.key t132.key t132_optDM.xyz 
echo " Test 132: completed" 
