#\!/bin/sh
# Test for TinkerLFMM: Test 136
 
rm -f lfse.in
echo " Test 136: Geometry Optimization" 
cp input/t136.xyz input/t136.key input/t136_optDM.xyz .
"$TINKERLFMMBIN"/minimize t136.xyz 0.01  > t136.log
if [ ! -f t136.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t136.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t136.xyz_2 t136_optTnk.xyz
cp t136.key t136_optTnk.key
"$TINKERLFMMBIN"/analyze t136_optTnk.xyz es >> t136.log
if [ ! -f t136.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t136.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t136 t136.log results_DommiMOE2011/t136_DommiMOE-OPT.log)
echo 136 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t136 t136.log results_DommiMOE2011/t136_DommiMOE-OPT.log)
echo 136 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t136_optDM.xyz t136_optTnk.key t136_optTnk.xyz 1 y u n 0.0 >> t136.log
result=$(grep "Root Mean Square Distance" t136.log -m1 | awk {'print $6'})
echo 136 t136 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t136.log t136_optTnk.xyz results_TinkerLFMM/
rm t136.xyz t136_optTnk.key t136.key t136_optDM.xyz 
echo " Test 136: completed" 
