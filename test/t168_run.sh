#\!/bin/sh
# Test for TinkerLFMM: Test 168
 
rm -f lfse.in
echo " Test 168: Geometry Optimization" 
cp input/t168.xyz input/t168.key input/t168_optDM.xyz .
"$TINKERLFMMBIN"/minimize t168.xyz 0.01  > t168.log
if [ ! -f t168.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t168.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t168.xyz_2 t168_optTnk.xyz
cp t168.key t168_optTnk.key
"$TINKERLFMMBIN"/analyze t168_optTnk.xyz es >> t168.log
if [ ! -f t168.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t168.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t168 t168.log results_DommiMOE2011/t168_DommiMOE-OPT.log)
echo 168 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t168 t168.log results_DommiMOE2011/t168_DommiMOE-OPT.log)
echo 168 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t168_optDM.xyz t168_optTnk.key t168_optTnk.xyz 1 y u n 0.0 >> t168.log
result=$(grep "Root Mean Square Distance" t168.log -m1 | awk {'print $6'})
echo 168 t168 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t168.log t168_optTnk.xyz results_TinkerLFMM/
rm t168.xyz t168_optTnk.key t168.key t168_optDM.xyz 
echo " Test 168: completed" 
