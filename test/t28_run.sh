#\!/bin/sh
# Test for TinkerLFMM: Test 28
 
rm -f lfse.in
echo " Test 28: Single Point LFMM " 
cp input/t28.xyz input/t28.key .
"$TINKERLFMMBIN"/analyze t28.xyz et > t28.log
if [ ! -f t28.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t28.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t28.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t28 t28.log results_DommiMOE2011/t28_DommiMOE-SP.log)
echo 28 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t28 t28.log results_DommiMOE2011/t28_DommiMOE-SP.log)
echo 28 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t28 t28.log results_DommiMOE2011/t28_DommiMOE-SP.log)
echo 28 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t28 t28.log results_DommiMOE2011/t28_DommiMOE-SP.log)
echo 28 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t28 t28.log results_DommiMOE2011/t28_DommiMOE-SP.log)
echo 28 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t28.* results_TinkerLFMM/
echo " Test 28: completed" 
