#\!/bin/sh
# Test for TinkerLFMM: Test 143
 
rm -f lfse.in
echo " Test 143: Geometry Optimization" 
cp input/t143.xyz input/t143.key input/t143_optDM.xyz .
"$TINKERLFMMBIN"/minimize t143.xyz 0.01  > t143.log
if [ ! -f t143.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t143.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t143.xyz_2 t143_optTnk.xyz
cp t143.key t143_optTnk.key
"$TINKERLFMMBIN"/analyze t143_optTnk.xyz es >> t143.log
if [ ! -f t143.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t143.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t143 t143.log results_DommiMOE2011/t143_DommiMOE-OPT.log)
echo 143 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t143 t143.log results_DommiMOE2011/t143_DommiMOE-OPT.log)
echo 143 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t143_optDM.xyz t143_optTnk.key t143_optTnk.xyz 1 y u n 0.0 >> t143.log
result=$(grep "Root Mean Square Distance" t143.log -m1 | awk {'print $6'})
echo 143 t143 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t143.log t143_optTnk.xyz results_TinkerLFMM/
rm t143.xyz t143_optTnk.key t143.key t143_optDM.xyz 
echo " Test 143: completed" 
