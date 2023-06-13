#\!/bin/sh
# Test for TinkerLFMM: Test 106
 
rm -f lfse.in
echo " Test 106: Geometry Optimization" 
cp input/t106.xyz input/t106.key input/t106_optDM.xyz .
"$TINKERLFMMBIN"/minimize t106.xyz 0.01  > t106.log
if [ ! -f t106.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t106.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t106.xyz_2 t106_optTnk.xyz
cp t106.key t106_optTnk.key
"$TINKERLFMMBIN"/analyze t106_optTnk.xyz es >> t106.log
if [ ! -f t106.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t106.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t106 t106.log results_DommiMOE2011/t106_DommiMOE-OPT.log)
echo 106 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t106 t106.log results_DommiMOE2011/t106_DommiMOE-OPT.log)
echo 106 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t106_optDM.xyz t106_optTnk.key t106_optTnk.xyz 1 y u n 0.0 >> t106.log
result=$(grep "Root Mean Square Distance" t106.log -m1 | awk {'print $6'})
echo 106 t106 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t106.log t106_optTnk.xyz results_TinkerLFMM/
rm t106.xyz t106_optTnk.key t106.key t106_optDM.xyz 
echo " Test 106: completed" 
