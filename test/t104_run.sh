#\!/bin/sh
# Test for TinkerLFMM: Test 104
 
rm -f lfse.in
echo " Test 104: Geometry Optimization" 
cp input/t104.xyz input/t104.key input/t104_optDM.xyz .
"$TINKERLFMMBIN"/minimize t104.xyz 0.01  > t104.log
if [ ! -f t104.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t104.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t104.xyz_2 t104_optTnk.xyz
cp t104.key t104_optTnk.key
"$TINKERLFMMBIN"/analyze t104_optTnk.xyz es >> t104.log
if [ ! -f t104.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t104.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t104 t104.log results_DommiMOE2011/t104_DommiMOE-OPT.log)
echo 104 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t104 t104.log results_DommiMOE2011/t104_DommiMOE-OPT.log)
echo 104 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t104_optDM.xyz t104_optTnk.key t104_optTnk.xyz 1 y u n 0.0 >> t104.log
result=$(grep "Root Mean Square Distance" t104.log -m1 | awk {'print $6'})
echo 104 t104 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t104.log t104_optTnk.xyz results_TinkerLFMM/
rm t104.xyz t104_optTnk.key t104.key t104_optDM.xyz 
echo " Test 104: completed" 
