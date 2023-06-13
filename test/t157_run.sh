#\!/bin/sh
# Test for TinkerLFMM: Test 157
 
rm -f lfse.in
echo " Test 157: Geometry Optimization" 
cp input/t157.xyz input/t157.key input/t157_optDM.xyz .
"$TINKERLFMMBIN"/minimize t157.xyz 0.01  > t157.log
if [ ! -f t157.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t157.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t157.xyz_2 t157_optTnk.xyz
cp t157.key t157_optTnk.key
"$TINKERLFMMBIN"/analyze t157_optTnk.xyz es >> t157.log
if [ ! -f t157.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t157.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t157 t157.log results_DommiMOE2011/t157_DommiMOE-OPT.log)
echo 157 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t157 t157.log results_DommiMOE2011/t157_DommiMOE-OPT.log)
echo 157 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t157_optDM.xyz t157_optTnk.key t157_optTnk.xyz 1 y u n 0.0 >> t157.log
result=$(grep "Root Mean Square Distance" t157.log -m1 | awk {'print $6'})
echo 157 t157 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t157.log t157_optTnk.xyz results_TinkerLFMM/
rm t157.xyz t157_optTnk.key t157.key t157_optDM.xyz 
echo " Test 157: completed" 
