#\!/bin/sh
# Test for TinkerLFMM: Test 174
 
rm -f lfse.in
echo " Test 174: Geometry Optimization" 
cp input/t174.xyz input/t174.key input/t174_optDM.xyz .
"$TINKERLFMMBIN"/minimize t174.xyz 0.01  > t174.log
if [ ! -f t174.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t174.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t174.xyz_2 t174_optTnk.xyz
cp t174.key t174_optTnk.key
"$TINKERLFMMBIN"/analyze t174_optTnk.xyz es >> t174.log
if [ ! -f t174.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t174.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t174 t174.log results_DommiMOE2011/t174_DommiMOE-OPT.log)
echo 174 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t174 t174.log results_DommiMOE2011/t174_DommiMOE-OPT.log)
echo 174 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t174_optDM.xyz t174_optTnk.key t174_optTnk.xyz 1 y u n 0.0 >> t174.log
result=$(grep "Root Mean Square Distance" t174.log -m1 | awk {'print $6'})
echo 174 t174 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t174.log t174_optTnk.xyz results_TinkerLFMM/
rm t174.xyz t174_optTnk.key t174.key t174_optDM.xyz 
echo " Test 174: completed" 
