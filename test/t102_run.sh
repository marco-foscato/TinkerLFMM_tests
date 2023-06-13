#\!/bin/sh
# Test for TinkerLFMM: Test 102
 
rm -f lfse.in
echo " Test 102: Geometry Optimization" 
cp input/t102.xyz input/t102.key input/t102_optDM.xyz .
"$TINKERLFMMBIN"/minimize t102.xyz 0.01  > t102.log
if [ ! -f t102.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t102.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t102.xyz_2 t102_optTnk.xyz
cp t102.key t102_optTnk.key
"$TINKERLFMMBIN"/analyze t102_optTnk.xyz es >> t102.log
if [ ! -f t102.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t102.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t102 t102.log results_DommiMOE2011/t102_DommiMOE-OPT.log)
echo 102 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t102 t102.log results_DommiMOE2011/t102_DommiMOE-OPT.log)
echo 102 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t102_optDM.xyz t102_optTnk.key t102_optTnk.xyz 1 y u n 0.0 >> t102.log
result=$(grep "Root Mean Square Distance" t102.log -m1 | awk {'print $6'})
echo 102 t102 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t102.log t102_optTnk.xyz results_TinkerLFMM/
rm t102.xyz t102_optTnk.key t102.key t102_optDM.xyz 
echo " Test 102: completed" 
