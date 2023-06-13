#\!/bin/sh
# Test for TinkerLFMM: Test 107
 
rm -f lfse.in
echo " Test 107: Geometry Optimization" 
cp input/t107.xyz input/t107.key input/t107_optDM.xyz .
"$TINKERLFMMBIN"/minimize t107.xyz 0.01  > t107.log
if [ ! -f t107.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t107.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t107.xyz_2 t107_optTnk.xyz
cp t107.key t107_optTnk.key
"$TINKERLFMMBIN"/analyze t107_optTnk.xyz es >> t107.log
if [ ! -f t107.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t107.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t107 t107.log results_DommiMOE2011/t107_DommiMOE-OPT.log)
echo 107 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t107 t107.log results_DommiMOE2011/t107_DommiMOE-OPT.log)
echo 107 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t107_optDM.xyz t107_optTnk.key t107_optTnk.xyz 1 y u n 0.0 >> t107.log
result=$(grep "Root Mean Square Distance" t107.log -m1 | awk {'print $6'})
echo 107 t107 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t107.log t107_optTnk.xyz results_TinkerLFMM/
rm t107.xyz t107_optTnk.key t107.key t107_optDM.xyz 
echo " Test 107: completed" 
