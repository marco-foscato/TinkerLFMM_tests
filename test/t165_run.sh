#\!/bin/sh
# Test for TinkerLFMM: Test 165
 
rm -f lfse.in
echo " Test 165: Geometry Optimization" 
cp input/t165.xyz input/t165.key input/t165_optDM.xyz .
"$TINKERLFMMBIN"/minimize t165.xyz 0.01  > t165.log
if [ ! -f t165.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t165.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t165.xyz_2 t165_optTnk.xyz
cp t165.key t165_optTnk.key
"$TINKERLFMMBIN"/analyze t165_optTnk.xyz es >> t165.log
if [ ! -f t165.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t165.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t165 t165.log results_DommiMOE2011/t165_DommiMOE-OPT.log)
echo 165 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t165 t165.log results_DommiMOE2011/t165_DommiMOE-OPT.log)
echo 165 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t165_optDM.xyz t165_optTnk.key t165_optTnk.xyz 1 y u n 0.0 >> t165.log
result=$(grep "Root Mean Square Distance" t165.log -m1 | awk {'print $6'})
echo 165 t165 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t165.log t165_optTnk.xyz results_TinkerLFMM/
rm t165.xyz t165_optTnk.key t165.key t165_optDM.xyz 
echo " Test 165: completed" 
