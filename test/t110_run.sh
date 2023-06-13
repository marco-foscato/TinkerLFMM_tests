#\!/bin/sh
# Test for TinkerLFMM: Test 110
 
rm -f lfse.in
echo " Test 110: Geometry Optimization" 
cp input/t110.xyz input/t110.key input/t110_optDM.xyz .
"$TINKERLFMMBIN"/minimize t110.xyz 0.01  > t110.log
if [ ! -f t110.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t110.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t110.xyz_2 t110_optTnk.xyz
cp t110.key t110_optTnk.key
"$TINKERLFMMBIN"/analyze t110_optTnk.xyz es >> t110.log
if [ ! -f t110.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t110.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t110 t110.log results_DommiMOE2011/t110_DommiMOE-OPT.log)
echo 110 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t110 t110.log results_DommiMOE2011/t110_DommiMOE-OPT.log)
echo 110 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t110_optDM.xyz t110_optTnk.key t110_optTnk.xyz 1 y u n 0.0 >> t110.log
result=$(grep "Root Mean Square Distance" t110.log -m1 | awk {'print $6'})
echo 110 t110 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t110.log t110_optTnk.xyz results_TinkerLFMM/
rm t110.xyz t110_optTnk.key t110.key t110_optDM.xyz 
echo " Test 110: completed" 
