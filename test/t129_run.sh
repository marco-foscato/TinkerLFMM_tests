#\!/bin/sh
# Test for TinkerLFMM: Test 129
 
rm -f lfse.in
echo " Test 129: Geometry Optimization" 
cp input/t129.xyz input/t129.key input/t129_optDM.xyz .
"$TINKERLFMMBIN"/minimize t129.xyz 0.01  > t129.log
if [ ! -f t129.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t129.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t129.xyz_2 t129_optTnk.xyz
cp t129.key t129_optTnk.key
"$TINKERLFMMBIN"/analyze t129_optTnk.xyz es >> t129.log
if [ ! -f t129.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t129.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t129 t129.log results_DommiMOE2011/t129_DommiMOE-OPT.log)
echo 129 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t129 t129.log results_DommiMOE2011/t129_DommiMOE-OPT.log)
echo 129 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t129_optDM.xyz t129_optTnk.key t129_optTnk.xyz 1 y u n 0.0 >> t129.log
result=$(grep "Root Mean Square Distance" t129.log -m1 | awk {'print $6'})
echo 129 t129 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t129.log t129_optTnk.xyz results_TinkerLFMM/
rm t129.xyz t129_optTnk.key t129.key t129_optDM.xyz 
echo " Test 129: completed" 
