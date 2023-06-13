#\!/bin/sh
# Test for TinkerLFMM: Test 43
 
rm -f lfse.in
echo " Test 43: Single Point LFMM " 
cp input/t43.xyz input/t43.key .
"$TINKERLFMMBIN"/analyze t43.xyz et > t43.log
if [ ! -f t43.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t43.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t43.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t43 t43.log results_DommiMOE2011/t43_DommiMOE-SP.log)
echo 43 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t43 t43.log results_DommiMOE2011/t43_DommiMOE-SP.log)
echo 43 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t43 t43.log results_DommiMOE2011/t43_DommiMOE-SP.log)
echo 43 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t43 t43.log results_DommiMOE2011/t43_DommiMOE-SP.log)
echo 43 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t43 t43.log results_DommiMOE2011/t43_DommiMOE-SP.log)
echo 43 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t43.* results_TinkerLFMM/
echo " Test 43: completed" 
