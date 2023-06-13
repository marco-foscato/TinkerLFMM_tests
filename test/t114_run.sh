#\!/bin/sh
# Test for TinkerLFMM: Test 114
 
rm -f lfse.in
echo " Test 114: Geometry Optimization" 
cp input/t114.xyz input/t114.key input/t114_optDM.xyz .
"$TINKERLFMMBIN"/minimize t114.xyz 0.01  > t114.log
if [ ! -f t114.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t114.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t114.xyz_2 t114_optTnk.xyz
cp t114.key t114_optTnk.key
"$TINKERLFMMBIN"/analyze t114_optTnk.xyz es >> t114.log
if [ ! -f t114.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t114.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t114 t114.log results_DommiMOE2011/t114_DommiMOE-OPT.log)
echo 114 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t114 t114.log results_DommiMOE2011/t114_DommiMOE-OPT.log)
echo 114 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t114_optDM.xyz t114_optTnk.key t114_optTnk.xyz 1 y u n 0.0 >> t114.log
result=$(grep "Root Mean Square Distance" t114.log -m1 | awk {'print $6'})
echo 114 t114 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t114.log t114_optTnk.xyz results_TinkerLFMM/
rm t114.xyz t114_optTnk.key t114.key t114_optDM.xyz 
echo " Test 114: completed" 
