#\!/bin/sh
# Test for TinkerLFMM: Test 130
 
rm -f lfse.in
echo " Test 130: Geometry Optimization" 
cp input/t130.xyz input/t130.key input/t130_optDM.xyz .
"$TINKERLFMMBIN"/minimize t130.xyz 0.01  > t130.log
if [ ! -f t130.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t130.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t130.xyz_2 t130_optTnk.xyz
cp t130.key t130_optTnk.key
"$TINKERLFMMBIN"/analyze t130_optTnk.xyz es >> t130.log
if [ ! -f t130.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t130.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t130 t130.log results_DommiMOE2011/t130_DommiMOE-OPT.log)
echo 130 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t130 t130.log results_DommiMOE2011/t130_DommiMOE-OPT.log)
echo 130 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t130_optDM.xyz t130_optTnk.key t130_optTnk.xyz 1 y u n 0.0 >> t130.log
result=$(grep "Root Mean Square Distance" t130.log -m1 | awk {'print $6'})
echo 130 t130 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t130.log t130_optTnk.xyz results_TinkerLFMM/
rm t130.xyz t130_optTnk.key t130.key t130_optDM.xyz 
echo " Test 130: completed" 
