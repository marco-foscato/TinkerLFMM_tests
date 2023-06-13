#\!/bin/sh
# Test for TinkerLFMM: Test 179
 
rm -f lfse.in
echo " Test 179: Geometry Optimization" 
cp input/t179.xyz input/t179.key input/t179_optDM.xyz .
"$TINKERLFMMBIN"/minimize t179.xyz 0.01  > t179.log
if [ ! -f t179.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t179.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t179.xyz_2 t179_optTnk.xyz
cp t179.key t179_optTnk.key
"$TINKERLFMMBIN"/analyze t179_optTnk.xyz es >> t179.log
if [ ! -f t179.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t179.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t179 t179.log results_DommiMOE2011/t179_DommiMOE-OPT.log)
echo 179 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t179 t179.log results_DommiMOE2011/t179_DommiMOE-OPT.log)
echo 179 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t179_optDM.xyz t179_optTnk.key t179_optTnk.xyz 1 y u n 0.0 >> t179.log
result=$(grep "Root Mean Square Distance" t179.log -m1 | awk {'print $6'})
echo 179 t179 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t179.log t179_optTnk.xyz results_TinkerLFMM/
rm t179.xyz t179_optTnk.key t179.key t179_optDM.xyz 
echo " Test 179: completed" 
