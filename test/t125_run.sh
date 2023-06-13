#\!/bin/sh
# Test for TinkerLFMM: Test 125
 
rm -f lfse.in
echo " Test 125: Geometry Optimization" 
cp input/t125.xyz input/t125.key input/t125_optDM.xyz .
"$TINKERLFMMBIN"/minimize t125.xyz 0.01  > t125.log
if [ ! -f t125.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t125.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t125.xyz_2 t125_optTnk.xyz
cp t125.key t125_optTnk.key
"$TINKERLFMMBIN"/analyze t125_optTnk.xyz es >> t125.log
if [ ! -f t125.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t125.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t125 t125.log results_DommiMOE2011/t125_DommiMOE-OPT.log)
echo 125 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t125 t125.log results_DommiMOE2011/t125_DommiMOE-OPT.log)
echo 125 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t125_optDM.xyz t125_optTnk.key t125_optTnk.xyz 1 y u n 0.0 >> t125.log
result=$(grep "Root Mean Square Distance" t125.log -m1 | awk {'print $6'})
echo 125 t125 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t125.log t125_optTnk.xyz results_TinkerLFMM/
rm t125.xyz t125_optTnk.key t125.key t125_optDM.xyz 
echo " Test 125: completed" 
