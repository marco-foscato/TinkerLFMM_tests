#\!/bin/sh
# Test for TinkerLFMM: Test 148
 
rm -f lfse.in
echo " Test 148: Geometry Optimization" 
cp input/t148.xyz input/t148.key input/t148_optDM.xyz .
"$TINKERLFMMBIN"/minimize t148.xyz 0.01  > t148.log
if [ ! -f t148.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t148.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t148.xyz_2 t148_optTnk.xyz
cp t148.key t148_optTnk.key
"$TINKERLFMMBIN"/analyze t148_optTnk.xyz es >> t148.log
if [ ! -f t148.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t148.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t148 t148.log results_DommiMOE2011/t148_DommiMOE-OPT.log)
echo 148 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t148 t148.log results_DommiMOE2011/t148_DommiMOE-OPT.log)
echo 148 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t148_optDM.xyz t148_optTnk.key t148_optTnk.xyz 1 y u n 0.0 >> t148.log
result=$(grep "Root Mean Square Distance" t148.log -m1 | awk {'print $6'})
echo 148 t148 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t148.log t148_optTnk.xyz results_TinkerLFMM/
rm t148.xyz t148_optTnk.key t148.key t148_optDM.xyz 
echo " Test 148: completed" 
