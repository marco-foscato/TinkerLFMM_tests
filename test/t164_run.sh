#\!/bin/sh
# Test for TinkerLFMM: Test 164
 
rm -f lfse.in
echo " Test 164: Geometry Optimization" 
cp input/t164.xyz input/t164.key input/t164_optDM.xyz .
"$TINKERLFMMBIN"/minimize t164.xyz 0.01  > t164.log
if [ ! -f t164.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t164.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t164.xyz_2 t164_optTnk.xyz
cp t164.key t164_optTnk.key
"$TINKERLFMMBIN"/analyze t164_optTnk.xyz es >> t164.log
if [ ! -f t164.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t164.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t164 t164.log results_DommiMOE2011/t164_DommiMOE-OPT.log)
echo 164 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t164 t164.log results_DommiMOE2011/t164_DommiMOE-OPT.log)
echo 164 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t164_optDM.xyz t164_optTnk.key t164_optTnk.xyz 1 y u n 0.0 >> t164.log
result=$(grep "Root Mean Square Distance" t164.log -m1 | awk {'print $6'})
echo 164 t164 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t164.log t164_optTnk.xyz results_TinkerLFMM/
rm t164.xyz t164_optTnk.key t164.key t164_optDM.xyz 
echo " Test 164: completed" 
