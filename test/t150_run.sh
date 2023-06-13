#\!/bin/sh
# Test for TinkerLFMM: Test 150
 
rm -f lfse.in
echo " Test 150: Geometry Optimization" 
cp input/t150.xyz input/t150.key input/t150_optDM.xyz .
"$TINKERLFMMBIN"/minimize t150.xyz 0.01  > t150.log
if [ ! -f t150.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t150.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t150.xyz_2 t150_optTnk.xyz
cp t150.key t150_optTnk.key
"$TINKERLFMMBIN"/analyze t150_optTnk.xyz es >> t150.log
if [ ! -f t150.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t150.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t150 t150.log results_DommiMOE2011/t150_DommiMOE-OPT.log)
echo 150 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t150 t150.log results_DommiMOE2011/t150_DommiMOE-OPT.log)
echo 150 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t150_optDM.xyz t150_optTnk.key t150_optTnk.xyz 1 y u n 0.0 >> t150.log
result=$(grep "Root Mean Square Distance" t150.log -m1 | awk {'print $6'})
echo 150 t150 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t150.log t150_optTnk.xyz results_TinkerLFMM/
rm t150.xyz t150_optTnk.key t150.key t150_optDM.xyz 
echo " Test 150: completed" 
