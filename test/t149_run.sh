#\!/bin/sh
# Test for TinkerLFMM: Test 149
 
rm -f lfse.in
echo " Test 149: Geometry Optimization" 
cp input/t149.xyz input/t149.key input/t149_optDM.xyz .
"$TINKERLFMMBIN"/minimize t149.xyz 0.01  > t149.log
if [ ! -f t149.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t149.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t149.xyz_2 t149_optTnk.xyz
cp t149.key t149_optTnk.key
"$TINKERLFMMBIN"/analyze t149_optTnk.xyz es >> t149.log
if [ ! -f t149.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t149.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t149 t149.log results_DommiMOE2011/t149_DommiMOE-OPT.log)
echo 149 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t149 t149.log results_DommiMOE2011/t149_DommiMOE-OPT.log)
echo 149 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t149_optDM.xyz t149_optTnk.key t149_optTnk.xyz 1 y u n 0.0 >> t149.log
result=$(grep "Root Mean Square Distance" t149.log -m1 | awk {'print $6'})
echo 149 t149 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t149.log t149_optTnk.xyz results_TinkerLFMM/
rm t149.xyz t149_optTnk.key t149.key t149_optDM.xyz 
echo " Test 149: completed" 
