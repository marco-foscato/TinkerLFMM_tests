#\!/bin/sh
# Test for TinkerLFMM: Test 121
 
rm -f lfse.in
echo " Test 121: Geometry Optimization" 
cp input/t121.xyz input/t121.key input/t121_optDM.xyz .
"$TINKERLFMMBIN"/minimize t121.xyz 0.01  > t121.log
if [ ! -f t121.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t121.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t121.xyz_2 t121_optTnk.xyz
cp t121.key t121_optTnk.key
"$TINKERLFMMBIN"/analyze t121_optTnk.xyz es >> t121.log
if [ ! -f t121.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t121.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t121 t121.log results_DommiMOE2011/t121_DommiMOE-OPT.log)
echo 121 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t121 t121.log results_DommiMOE2011/t121_DommiMOE-OPT.log)
echo 121 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t121_optDM.xyz t121_optTnk.key t121_optTnk.xyz 1 y u n 0.0 >> t121.log
result=$(grep "Root Mean Square Distance" t121.log -m1 | awk {'print $6'})
echo 121 t121 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t121.log t121_optTnk.xyz results_TinkerLFMM/
rm t121.xyz t121_optTnk.key t121.key t121_optDM.xyz 
echo " Test 121: completed" 
