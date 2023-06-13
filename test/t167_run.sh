#\!/bin/sh
# Test for TinkerLFMM: Test 167
 
rm -f lfse.in
echo " Test 167: Geometry Optimization" 
cp input/t167.xyz input/t167.key input/t167_optDM.xyz .
"$TINKERLFMMBIN"/minimize t167.xyz 0.01  > t167.log
if [ ! -f t167.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t167.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t167.xyz_2 t167_optTnk.xyz
cp t167.key t167_optTnk.key
"$TINKERLFMMBIN"/analyze t167_optTnk.xyz es >> t167.log
if [ ! -f t167.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t167.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t167 t167.log results_DommiMOE2011/t167_DommiMOE-OPT.log)
echo 167 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t167 t167.log results_DommiMOE2011/t167_DommiMOE-OPT.log)
echo 167 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t167_optDM.xyz t167_optTnk.key t167_optTnk.xyz 1 y u n 0.0 >> t167.log
result=$(grep "Root Mean Square Distance" t167.log -m1 | awk {'print $6'})
echo 167 t167 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t167.log t167_optTnk.xyz results_TinkerLFMM/
rm t167.xyz t167_optTnk.key t167.key t167_optDM.xyz 
echo " Test 167: completed" 
