#\!/bin/sh
# Test for TinkerLFMM: Test 124
 
rm -f lfse.in
echo " Test 124: Geometry Optimization" 
cp input/t124.xyz input/t124.key input/t124_optDM.xyz .
"$TINKERLFMMBIN"/minimize t124.xyz 0.01  > t124.log
if [ ! -f t124.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t124.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t124.xyz_2 t124_optTnk.xyz
cp t124.key t124_optTnk.key
"$TINKERLFMMBIN"/analyze t124_optTnk.xyz es >> t124.log
if [ ! -f t124.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t124.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t124 t124.log results_DommiMOE2011/t124_DommiMOE-OPT.log)
echo 124 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t124 t124.log results_DommiMOE2011/t124_DommiMOE-OPT.log)
echo 124 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t124_optDM.xyz t124_optTnk.key t124_optTnk.xyz 1 y u n 0.0 >> t124.log
result=$(grep "Root Mean Square Distance" t124.log -m1 | awk {'print $6'})
echo 124 t124 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t124.log t124_optTnk.xyz results_TinkerLFMM/
rm t124.xyz t124_optTnk.key t124.key t124_optDM.xyz 
echo " Test 124: completed" 
