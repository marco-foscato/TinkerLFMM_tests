#\!/bin/sh
# Test for TinkerLFMM: Test 133
 
rm -f lfse.in
echo " Test 133: Geometry Optimization" 
cp input/t133.xyz input/t133.key input/t133_optDM.xyz .
"$TINKERLFMMBIN"/minimize t133.xyz 0.01  > t133.log
if [ ! -f t133.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t133.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t133.xyz_2 t133_optTnk.xyz
cp t133.key t133_optTnk.key
"$TINKERLFMMBIN"/analyze t133_optTnk.xyz es >> t133.log
if [ ! -f t133.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t133.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t133 t133.log results_DommiMOE2011/t133_DommiMOE-OPT.log)
echo 133 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t133 t133.log results_DommiMOE2011/t133_DommiMOE-OPT.log)
echo 133 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t133_optDM.xyz t133_optTnk.key t133_optTnk.xyz 1 y u n 0.0 >> t133.log
result=$(grep "Root Mean Square Distance" t133.log -m1 | awk {'print $6'})
echo 133 t133 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t133.log t133_optTnk.xyz results_TinkerLFMM/
rm t133.xyz t133_optTnk.key t133.key t133_optDM.xyz 
echo " Test 133: completed" 
