#\!/bin/sh
# Test for TinkerLFMM: Test 156
 
rm -f lfse.in
echo " Test 156: Geometry Optimization" 
cp input/t156.xyz input/t156.key input/t156_optDM.xyz .
"$TINKERLFMMBIN"/minimize t156.xyz 0.01  > t156.log
if [ ! -f t156.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t156.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t156.xyz_2 t156_optTnk.xyz
cp t156.key t156_optTnk.key
"$TINKERLFMMBIN"/analyze t156_optTnk.xyz es >> t156.log
if [ ! -f t156.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t156.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t156 t156.log results_DommiMOE2011/t156_DommiMOE-OPT.log)
echo 156 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t156 t156.log results_DommiMOE2011/t156_DommiMOE-OPT.log)
echo 156 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t156_optDM.xyz t156_optTnk.key t156_optTnk.xyz 1 y u n 0.0 >> t156.log
result=$(grep "Root Mean Square Distance" t156.log -m1 | awk {'print $6'})
echo 156 t156 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t156.log t156_optTnk.xyz results_TinkerLFMM/
rm t156.xyz t156_optTnk.key t156.key t156_optDM.xyz 
echo " Test 156: completed" 
