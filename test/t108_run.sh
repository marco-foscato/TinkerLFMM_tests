#\!/bin/sh
# Test for TinkerLFMM: Test 108
 
rm -f lfse.in
echo " Test 108: Geometry Optimization" 
cp input/t108.xyz input/t108.key input/t108_optDM.xyz .
"$TINKERLFMMBIN"/minimize t108.xyz 0.01  > t108.log
if [ ! -f t108.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t108.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t108.xyz_2 t108_optTnk.xyz
cp t108.key t108_optTnk.key
"$TINKERLFMMBIN"/analyze t108_optTnk.xyz es >> t108.log
if [ ! -f t108.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t108.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t108 t108.log results_DommiMOE2011/t108_DommiMOE-OPT.log)
echo 108 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t108 t108.log results_DommiMOE2011/t108_DommiMOE-OPT.log)
echo 108 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t108_optDM.xyz t108_optTnk.key t108_optTnk.xyz 1 y u n 0.0 >> t108.log
result=$(grep "Root Mean Square Distance" t108.log -m1 | awk {'print $6'})
echo 108 t108 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t108.log t108_optTnk.xyz results_TinkerLFMM/
rm t108.xyz t108_optTnk.key t108.key t108_optDM.xyz 
echo " Test 108: completed" 
