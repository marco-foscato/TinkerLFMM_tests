#\!/bin/sh
# Test for TinkerLFMM: Test 113
 
rm -f lfse.in
echo " Test 113: Geometry Optimization" 
cp input/t113.xyz input/t113.key input/t113_optDM.xyz .
"$TINKERLFMMBIN"/minimize t113.xyz 0.01  > t113.log
if [ ! -f t113.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t113.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t113.xyz_2 t113_optTnk.xyz
cp t113.key t113_optTnk.key
"$TINKERLFMMBIN"/analyze t113_optTnk.xyz es >> t113.log
if [ ! -f t113.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t113.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t113 t113.log results_DommiMOE2011/t113_DommiMOE-OPT.log)
echo 113 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t113 t113.log results_DommiMOE2011/t113_DommiMOE-OPT.log)
echo 113 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t113_optDM.xyz t113_optTnk.key t113_optTnk.xyz 1 y u n 0.0 >> t113.log
result=$(grep "Root Mean Square Distance" t113.log -m1 | awk {'print $6'})
echo 113 t113 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t113.log t113_optTnk.xyz results_TinkerLFMM/
rm t113.xyz t113_optTnk.key t113.key t113_optDM.xyz 
echo " Test 113: completed" 
