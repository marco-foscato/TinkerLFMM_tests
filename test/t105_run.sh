#\!/bin/sh
# Test for TinkerLFMM: Test 105
 
rm -f lfse.in
echo " Test 105: Geometry Optimization" 
cp input/t105.xyz input/t105.key input/t105_optDM.xyz .
"$TINKERLFMMBIN"/minimize t105.xyz 0.01  > t105.log
if [ ! -f t105.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t105.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t105.xyz_2 t105_optTnk.xyz
cp t105.key t105_optTnk.key
"$TINKERLFMMBIN"/analyze t105_optTnk.xyz es >> t105.log
if [ ! -f t105.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t105.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t105 t105.log results_DommiMOE2011/t105_DommiMOE-OPT.log)
echo 105 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t105 t105.log results_DommiMOE2011/t105_DommiMOE-OPT.log)
echo 105 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t105_optDM.xyz t105_optTnk.key t105_optTnk.xyz 1 y u n 0.0 >> t105.log
result=$(grep "Root Mean Square Distance" t105.log -m1 | awk {'print $6'})
echo 105 t105 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t105.log t105_optTnk.xyz results_TinkerLFMM/
rm t105.xyz t105_optTnk.key t105.key t105_optDM.xyz 
echo " Test 105: completed" 
