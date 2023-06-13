#\!/bin/sh
# Test for TinkerLFMM: Test 178
 
rm -f lfse.in
echo " Test 178: Geometry Optimization" 
cp input/t178.xyz input/t178.key input/t178_optDM.xyz .
"$TINKERLFMMBIN"/minimize t178.xyz 0.01  > t178.log
if [ ! -f t178.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t178.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t178.xyz_2 t178_optTnk.xyz
cp t178.key t178_optTnk.key
"$TINKERLFMMBIN"/analyze t178_optTnk.xyz es >> t178.log
if [ ! -f t178.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t178.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t178 t178.log results_DommiMOE2011/t178_DommiMOE-OPT.log)
echo 178 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t178 t178.log results_DommiMOE2011/t178_DommiMOE-OPT.log)
echo 178 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t178_optDM.xyz t178_optTnk.key t178_optTnk.xyz 1 y u n 0.0 >> t178.log
result=$(grep "Root Mean Square Distance" t178.log -m1 | awk {'print $6'})
echo 178 t178 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t178.log t178_optTnk.xyz results_TinkerLFMM/
rm t178.xyz t178_optTnk.key t178.key t178_optDM.xyz 
echo " Test 178: completed" 
