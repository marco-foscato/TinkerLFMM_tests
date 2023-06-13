#\!/bin/sh
# Test for TinkerLFMM: Test 170
 
rm -f lfse.in
echo " Test 170: Geometry Optimization" 
cp input/t170.xyz input/t170.key input/t170_optDM.xyz .
"$TINKERLFMMBIN"/minimize t170.xyz 0.01  > t170.log
if [ ! -f t170.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t170.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t170.xyz_2 t170_optTnk.xyz
cp t170.key t170_optTnk.key
"$TINKERLFMMBIN"/analyze t170_optTnk.xyz es >> t170.log
if [ ! -f t170.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t170.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t170 t170.log results_DommiMOE2011/t170_DommiMOE-OPT.log)
echo 170 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t170 t170.log results_DommiMOE2011/t170_DommiMOE-OPT.log)
echo 170 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t170_optDM.xyz t170_optTnk.key t170_optTnk.xyz 1 y u n 0.0 >> t170.log
result=$(grep "Root Mean Square Distance" t170.log -m1 | awk {'print $6'})
echo 170 t170 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t170.log t170_optTnk.xyz results_TinkerLFMM/
rm t170.xyz t170_optTnk.key t170.key t170_optDM.xyz 
echo " Test 170: completed" 
