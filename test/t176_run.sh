#\!/bin/sh
# Test for TinkerLFMM: Test 176
 
rm -f lfse.in
echo " Test 176: Geometry Optimization" 
cp input/t176.xyz input/t176.key input/t176_optDM.xyz .
"$TINKERLFMMBIN"/minimize t176.xyz 0.01  > t176.log
if [ ! -f t176.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t176.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t176.xyz_2 t176_optTnk.xyz
cp t176.key t176_optTnk.key
"$TINKERLFMMBIN"/analyze t176_optTnk.xyz es >> t176.log
if [ ! -f t176.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t176.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t176 t176.log results_DommiMOE2011/t176_DommiMOE-OPT.log)
echo 176 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t176 t176.log results_DommiMOE2011/t176_DommiMOE-OPT.log)
echo 176 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t176_optDM.xyz t176_optTnk.key t176_optTnk.xyz 1 y u n 0.0 >> t176.log
result=$(grep "Root Mean Square Distance" t176.log -m1 | awk {'print $6'})
echo 176 t176 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t176.log t176_optTnk.xyz results_TinkerLFMM/
rm t176.xyz t176_optTnk.key t176.key t176_optDM.xyz 
echo " Test 176: completed" 
