#\!/bin/sh
# Test for TinkerLFMM: Test 163
 
rm -f lfse.in
echo " Test 163: Geometry Optimization" 
cp input/t163.xyz input/t163.key input/t163_optDM.xyz .
"$TINKERLFMMBIN"/minimize t163.xyz 0.01  > t163.log
if [ ! -f t163.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t163.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t163.xyz_2 t163_optTnk.xyz
cp t163.key t163_optTnk.key
"$TINKERLFMMBIN"/analyze t163_optTnk.xyz es >> t163.log
if [ ! -f t163.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t163.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t163 t163.log results_DommiMOE2011/t163_DommiMOE-OPT.log)
echo 163 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t163 t163.log results_DommiMOE2011/t163_DommiMOE-OPT.log)
echo 163 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t163_optDM.xyz t163_optTnk.key t163_optTnk.xyz 1 y u n 0.0 >> t163.log
result=$(grep "Root Mean Square Distance" t163.log -m1 | awk {'print $6'})
echo 163 t163 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t163.log t163_optTnk.xyz results_TinkerLFMM/
rm t163.xyz t163_optTnk.key t163.key t163_optDM.xyz 
echo " Test 163: completed" 
