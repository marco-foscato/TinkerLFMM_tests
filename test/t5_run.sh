#\!/bin/sh
# Test for TinkerLFMM: Test 5
 
rm -f lfse.in
echo " Test 5: Single Point LFMM " 
cp input/t5.xyz input/t5.key .
"$TINKERLFMMBIN"/analyze t5.xyz et > t5.log
if [ ! -f t5.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t5.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t5.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t5 t5.log results_DommiMOE2011/t5_DommiMOE-SP.log)
echo 5 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t5 t5.log results_DommiMOE2011/t5_DommiMOE-SP.log)
echo 5 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t5 t5.log results_DommiMOE2011/t5_DommiMOE-SP.log)
echo 5 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t5 t5.log results_DommiMOE2011/t5_DommiMOE-SP.log)
echo 5 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t5 t5.log results_DommiMOE2011/t5_DommiMOE-SP.log)
echo 5 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t5.* results_TinkerLFMM/
echo " Test 5: completed" 
