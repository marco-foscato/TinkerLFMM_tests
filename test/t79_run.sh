#\!/bin/sh
# Test for TinkerLFMM: Test 79
 
rm -f lfse.in
echo " Test 79: Single Point LFMM " 
cp input/t79.xyz input/t79.key .
"$TINKERLFMMBIN"/analyze t79.xyz et > t79.log
if [ ! -f t79.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t79.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t79.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t79 t79.log results_DommiMOE2011/t79_DommiMOE-SP.log)
echo 79 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t79 t79.log results_DommiMOE2011/t79_DommiMOE-SP.log)
echo 79 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t79 t79.log results_DommiMOE2011/t79_DommiMOE-SP.log)
echo 79 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t79 t79.log results_DommiMOE2011/t79_DommiMOE-SP.log)
echo 79 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t79 t79.log results_DommiMOE2011/t79_DommiMOE-SP.log)
echo 79 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t79.* results_TinkerLFMM/
echo " Test 79: completed" 
