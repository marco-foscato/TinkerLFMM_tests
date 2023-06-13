#\!/bin/sh
# Test for TinkerLFMM: Test 166
 
rm -f lfse.in
echo " Test 166: Geometry Optimization" 
cp input/t166.xyz input/t166.key input/t166_optDM.xyz .
"$TINKERLFMMBIN"/minimize t166.xyz 0.01  > t166.log
if [ ! -f t166.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t166.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t166.xyz_2 t166_optTnk.xyz
cp t166.key t166_optTnk.key
"$TINKERLFMMBIN"/analyze t166_optTnk.xyz es >> t166.log
if [ ! -f t166.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t166.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t166 t166.log results_DommiMOE2011/t166_DommiMOE-OPT.log)
echo 166 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t166 t166.log results_DommiMOE2011/t166_DommiMOE-OPT.log)
echo 166 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t166_optDM.xyz t166_optTnk.key t166_optTnk.xyz 1 y u n 0.0 >> t166.log
result=$(grep "Root Mean Square Distance" t166.log -m1 | awk {'print $6'})
echo 166 t166 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t166.log t166_optTnk.xyz results_TinkerLFMM/
rm t166.xyz t166_optTnk.key t166.key t166_optDM.xyz 
echo " Test 166: completed" 
