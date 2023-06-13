#\!/bin/sh
# Test for TinkerLFMM: Test 162
 
rm -f lfse.in
echo " Test 162: Geometry Optimization" 
cp input/t162.xyz input/t162.key input/t162_optDM.xyz .
"$TINKERLFMMBIN"/minimize t162.xyz 0.01  > t162.log
if [ ! -f t162.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t162.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t162.xyz_2 t162_optTnk.xyz
cp t162.key t162_optTnk.key
"$TINKERLFMMBIN"/analyze t162_optTnk.xyz es >> t162.log
if [ ! -f t162.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t162.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t162 t162.log results_DommiMOE2011/t162_DommiMOE-OPT.log)
echo 162 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t162 t162.log results_DommiMOE2011/t162_DommiMOE-OPT.log)
echo 162 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t162_optDM.xyz t162_optTnk.key t162_optTnk.xyz 1 y u n 0.0 >> t162.log
result=$(grep "Root Mean Square Distance" t162.log -m1 | awk {'print $6'})
echo 162 t162 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t162.log t162_optTnk.xyz results_TinkerLFMM/
rm t162.xyz t162_optTnk.key t162.key t162_optDM.xyz 
echo " Test 162: completed" 
