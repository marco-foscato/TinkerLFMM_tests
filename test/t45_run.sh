#\!/bin/sh
# Test for TinkerLFMM: Test 45
 
rm -f lfse.in
echo " Test 45: Single Point LFMM " 
cp input/t45.xyz input/t45.key .
"$TINKERLFMMBIN"/analyze t45.xyz et > t45.log
if [ ! -f t45.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t45.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t45.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t45 t45.log results_DommiMOE2011/t45_DommiMOE-SP.log)
echo 45 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t45 t45.log results_DommiMOE2011/t45_DommiMOE-SP.log)
echo 45 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t45 t45.log results_DommiMOE2011/t45_DommiMOE-SP.log)
echo 45 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t45 t45.log results_DommiMOE2011/t45_DommiMOE-SP.log)
echo 45 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t45 t45.log results_DommiMOE2011/t45_DommiMOE-SP.log)
echo 45 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t45.* results_TinkerLFMM/
echo " Test 45: completed" 
