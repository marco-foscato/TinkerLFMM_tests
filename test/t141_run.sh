#\!/bin/sh
# Test for TinkerLFMM: Test 141
 
rm -f lfse.in
echo " Test 141: Geometry Optimization" 
cp input/t141.xyz input/t141.key input/t141_optDM.xyz .
"$TINKERLFMMBIN"/minimize t141.xyz 0.01  > t141.log
if [ ! -f t141.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t141.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t141.xyz_2 t141_optTnk.xyz
cp t141.key t141_optTnk.key
"$TINKERLFMMBIN"/analyze t141_optTnk.xyz es >> t141.log
if [ ! -f t141.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t141.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t141 t141.log results_DommiMOE2011/t141_DommiMOE-OPT.log)
echo 141 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t141 t141.log results_DommiMOE2011/t141_DommiMOE-OPT.log)
echo 141 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t141_optDM.xyz t141_optTnk.key t141_optTnk.xyz 1 y u n 0.0 >> t141.log
result=$(grep "Root Mean Square Distance" t141.log -m1 | awk {'print $6'})
echo 141 t141 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t141.log t141_optTnk.xyz results_TinkerLFMM/
rm t141.xyz t141_optTnk.key t141.key t141_optDM.xyz 
echo " Test 141: completed" 
