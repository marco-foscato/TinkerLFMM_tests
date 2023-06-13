#\!/bin/sh
# Test for TinkerLFMM: Test 120
 
rm -f lfse.in
echo " Test 120: Geometry Optimization" 
cp input/t120.xyz input/t120.key input/t120_optDM.xyz .
"$TINKERLFMMBIN"/minimize t120.xyz 0.01  > t120.log
if [ ! -f t120.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t120.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t120.xyz_2 t120_optTnk.xyz
cp t120.key t120_optTnk.key
"$TINKERLFMMBIN"/analyze t120_optTnk.xyz es >> t120.log
if [ ! -f t120.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t120.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t120 t120.log results_DommiMOE2011/t120_DommiMOE-OPT.log)
echo 120 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t120 t120.log results_DommiMOE2011/t120_DommiMOE-OPT.log)
echo 120 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t120_optDM.xyz t120_optTnk.key t120_optTnk.xyz 1 y u n 0.0 >> t120.log
result=$(grep "Root Mean Square Distance" t120.log -m1 | awk {'print $6'})
echo 120 t120 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t120.log t120_optTnk.xyz results_TinkerLFMM/
rm t120.xyz t120_optTnk.key t120.key t120_optDM.xyz 
echo " Test 120: completed" 
