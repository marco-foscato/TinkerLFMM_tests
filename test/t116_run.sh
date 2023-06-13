#\!/bin/sh
# Test for TinkerLFMM: Test 116
 
rm -f lfse.in
echo " Test 116: Geometry Optimization" 
cp input/t116.xyz input/t116.key input/t116_optDM.xyz .
"$TINKERLFMMBIN"/minimize t116.xyz 0.01  > t116.log
if [ ! -f t116.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t116.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t116.xyz_2 t116_optTnk.xyz
cp t116.key t116_optTnk.key
"$TINKERLFMMBIN"/analyze t116_optTnk.xyz es >> t116.log
if [ ! -f t116.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t116.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t116 t116.log results_DommiMOE2011/t116_DommiMOE-OPT.log)
echo 116 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t116 t116.log results_DommiMOE2011/t116_DommiMOE-OPT.log)
echo 116 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t116_optDM.xyz t116_optTnk.key t116_optTnk.xyz 1 y u n 0.0 >> t116.log
result=$(grep "Root Mean Square Distance" t116.log -m1 | awk {'print $6'})
echo 116 t116 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t116.log t116_optTnk.xyz results_TinkerLFMM/
rm t116.xyz t116_optTnk.key t116.key t116_optDM.xyz 
echo " Test 116: completed" 
