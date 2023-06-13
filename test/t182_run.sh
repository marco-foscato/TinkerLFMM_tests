#\!/bin/sh
# Test for TinkerLFMM: Test 182
 
rm -f lfse.in
echo " Test 182: Geometry Optimization" 
cp input/t182.xyz input/t182.key input/t182_optDM.xyz .
"$TINKERLFMMBIN"/minimize t182.xyz 0.01  > t182.log
if [ ! -f t182.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t182.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t182.xyz_2 t182_optTnk.xyz
cp t182.key t182_optTnk.key
"$TINKERLFMMBIN"/analyze t182_optTnk.xyz es >> t182.log
if [ ! -f t182.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t182.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t182 t182.log results_DommiMOE2011/t182_DommiMOE-OPT.log)
echo 182 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t182 t182.log results_DommiMOE2011/t182_DommiMOE-OPT.log)
echo 182 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t182_optDM.xyz t182_optTnk.key t182_optTnk.xyz 1 y u n 0.0 >> t182.log
result=$(grep "Root Mean Square Distance" t182.log -m1 | awk {'print $6'})
echo 182 t182 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t182.log t182_optTnk.xyz results_TinkerLFMM/
rm t182.xyz t182_optTnk.key t182.key t182_optDM.xyz 
echo " Test 182: completed" 
