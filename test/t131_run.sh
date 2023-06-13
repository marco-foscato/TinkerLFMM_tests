#\!/bin/sh
# Test for TinkerLFMM: Test 131
 
rm -f lfse.in
echo " Test 131: Geometry Optimization" 
cp input/t131.xyz input/t131.key input/t131_optDM.xyz .
"$TINKERLFMMBIN"/minimize t131.xyz 0.01  > t131.log
if [ ! -f t131.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t131.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t131.xyz_2 t131_optTnk.xyz
cp t131.key t131_optTnk.key
"$TINKERLFMMBIN"/analyze t131_optTnk.xyz es >> t131.log
if [ ! -f t131.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t131.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t131 t131.log results_DommiMOE2011/t131_DommiMOE-OPT.log)
echo 131 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t131 t131.log results_DommiMOE2011/t131_DommiMOE-OPT.log)
echo 131 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t131_optDM.xyz t131_optTnk.key t131_optTnk.xyz 1 y u n 0.0 >> t131.log
result=$(grep "Root Mean Square Distance" t131.log -m1 | awk {'print $6'})
echo 131 t131 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t131.log t131_optTnk.xyz results_TinkerLFMM/
rm t131.xyz t131_optTnk.key t131.key t131_optDM.xyz 
echo " Test 131: completed" 
