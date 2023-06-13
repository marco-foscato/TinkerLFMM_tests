#\!/bin/sh
# Test for TinkerLFMM: Test 15
 
rm -f lfse.in
echo " Test 15: Single Point LFMM " 
cp input/t15.xyz input/t15.key .
"$TINKERLFMMBIN"/analyze t15.xyz et > t15.log
if [ ! -f t15.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t15.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t15.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t15 t15.log results_DommiMOE2011/t15_DommiMOE-SP.log)
echo 15 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t15 t15.log results_DommiMOE2011/t15_DommiMOE-SP.log)
echo 15 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t15 t15.log results_DommiMOE2011/t15_DommiMOE-SP.log)
echo 15 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t15 t15.log results_DommiMOE2011/t15_DommiMOE-SP.log)
echo 15 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t15 t15.log results_DommiMOE2011/t15_DommiMOE-SP.log)
echo 15 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t15.* results_TinkerLFMM/
echo " Test 15: completed" 
