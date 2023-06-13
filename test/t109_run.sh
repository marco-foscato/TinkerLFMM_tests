#\!/bin/sh
# Test for TinkerLFMM: Test 109
 
rm -f lfse.in
echo " Test 109: Geometry Optimization" 
cp input/t109.xyz input/t109.key input/t109_optDM.xyz .
"$TINKERLFMMBIN"/minimize t109.xyz 0.01  > t109.log
if [ ! -f t109.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t109.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t109.xyz_2 t109_optTnk.xyz
cp t109.key t109_optTnk.key
"$TINKERLFMMBIN"/analyze t109_optTnk.xyz es >> t109.log
if [ ! -f t109.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t109.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t109 t109.log results_DommiMOE2011/t109_DommiMOE-OPT.log)
echo 109 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t109 t109.log results_DommiMOE2011/t109_DommiMOE-OPT.log)
echo 109 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t109_optDM.xyz t109_optTnk.key t109_optTnk.xyz 1 y u n 0.0 >> t109.log
result=$(grep "Root Mean Square Distance" t109.log -m1 | awk {'print $6'})
echo 109 t109 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t109.log t109_optTnk.xyz results_TinkerLFMM/
rm t109.xyz t109_optTnk.key t109.key t109_optDM.xyz 
echo " Test 109: completed" 
