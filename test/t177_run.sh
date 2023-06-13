#\!/bin/sh
# Test for TinkerLFMM: Test 177
 
rm -f lfse.in
echo " Test 177: Geometry Optimization" 
cp input/t177.xyz input/t177.key input/t177_optDM.xyz .
"$TINKERLFMMBIN"/minimize t177.xyz 0.01  > t177.log
if [ ! -f t177.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t177.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t177.xyz_2 t177_optTnk.xyz
cp t177.key t177_optTnk.key
"$TINKERLFMMBIN"/analyze t177_optTnk.xyz es >> t177.log
if [ ! -f t177.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t177.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t177 t177.log results_DommiMOE2011/t177_DommiMOE-OPT.log)
echo 177 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t177 t177.log results_DommiMOE2011/t177_DommiMOE-OPT.log)
echo 177 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t177_optDM.xyz t177_optTnk.key t177_optTnk.xyz 1 y u n 0.0 >> t177.log
result=$(grep "Root Mean Square Distance" t177.log -m1 | awk {'print $6'})
echo 177 t177 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t177.log t177_optTnk.xyz results_TinkerLFMM/
rm t177.xyz t177_optTnk.key t177.key t177_optDM.xyz 
echo " Test 177: completed" 
