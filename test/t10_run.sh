#\!/bin/sh
# Test for TinkerLFMM: Test 10
 
rm -f lfse.in
echo " Test 10: Single Point LFMM " 
cp input/t10.xyz input/t10.key .
"$TINKERLFMMBIN"/analyze t10.xyz et > t10.log
if [ ! -f t10.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t10.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t10.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t10 t10.log results_DommiMOE2011/t10_DommiMOE-SP.log)
echo 10 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t10 t10.log results_DommiMOE2011/t10_DommiMOE-SP.log)
echo 10 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t10 t10.log results_DommiMOE2011/t10_DommiMOE-SP.log)
echo 10 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t10 t10.log results_DommiMOE2011/t10_DommiMOE-SP.log)
echo 10 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t10 t10.log results_DommiMOE2011/t10_DommiMOE-SP.log)
echo 10 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t10.* results_TinkerLFMM/
echo " Test 10: completed" 
