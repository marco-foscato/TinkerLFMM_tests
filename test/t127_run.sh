#\!/bin/sh
# Test for TinkerLFMM: Test 127
 
rm -f lfse.in
echo " Test 127: Geometry Optimization" 
cp input/t127.xyz input/t127.key input/t127_optDM.xyz .
"$TINKERLFMMBIN"/minimize t127.xyz 0.01  > t127.log
if [ ! -f t127.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t127.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t127.xyz_2 t127_optTnk.xyz
cp t127.key t127_optTnk.key
"$TINKERLFMMBIN"/analyze t127_optTnk.xyz es >> t127.log
if [ ! -f t127.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t127.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t127 t127.log results_DommiMOE2011/t127_DommiMOE-OPT.log)
echo 127 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t127 t127.log results_DommiMOE2011/t127_DommiMOE-OPT.log)
echo 127 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t127_optDM.xyz t127_optTnk.key t127_optTnk.xyz 1 y u n 0.0 >> t127.log
result=$(grep "Root Mean Square Distance" t127.log -m1 | awk {'print $6'})
echo 127 t127 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t127.log t127_optTnk.xyz results_TinkerLFMM/
rm t127.xyz t127_optTnk.key t127.key t127_optDM.xyz 
echo " Test 127: completed" 
