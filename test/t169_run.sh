#\!/bin/sh
# Test for TinkerLFMM: Test 169
 
rm -f lfse.in
echo " Test 169: Geometry Optimization" 
cp input/t169.xyz input/t169.key input/t169_optDM.xyz .
"$TINKERLFMMBIN"/minimize t169.xyz 0.01  > t169.log
if [ ! -f t169.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t169.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-minimize did not terminate normally
        exit 2
    fi
fi
mv t169.xyz_2 t169_optTnk.xyz
cp t169.key t169_optTnk.key
"$TINKERLFMMBIN"/analyze t169_optTnk.xyz es >> t169.log
if [ ! -f t169.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t169.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker-analyze did not terminate normally
        exit 2
    fi
fi
# Compare energy opt 
result=$(./compareEnergyTerms_relative.sh t169 t169.log results_DommiMOE2011/t169_DommiMOE-OPT.log)
echo 169 $result >> results_TinkerLFMM/diffEnergy_opt_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t169 t169.log results_DommiMOE2011/t169_DommiMOE-OPT.log)
echo 169 $result >> results_TinkerLFMM/diffEnergy_opt.dat
 
# Compare optimized geometries  
"$TINKERLFMMBIN"/superpose t169_optDM.xyz t169_optTnk.key t169_optTnk.xyz 1 y u n 0.0 >> t169.log
result=$(grep "Root Mean Square Distance" t169.log -m1 | awk {'print $6'})
echo 169 t169 $result >> results_TinkerLFMM/diffGeometries_opt.dat
 
# Cleanup 
mv t169.log t169_optTnk.xyz results_TinkerLFMM/
rm t169.xyz t169_optTnk.key t169.key t169_optDM.xyz 
echo " Test 169: completed" 
