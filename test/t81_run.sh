#\!/bin/sh
# Test for TinkerLFMM: Test 81
 
rm -f lfse.in
echo " Test 81: Single Point LFMM " 
cp input/t81.xyz input/t81.key .
"$TINKERLFMMBIN"/analyze t81.xyz et > t81.log
if [ ! -f t81.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t81.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t81.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t81 t81.log results_DommiMOE2011/t81_DommiMOE-SP.log)
echo 81 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t81 t81.log results_DommiMOE2011/t81_DommiMOE-SP.log)
echo 81 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t81 t81.log results_DommiMOE2011/t81_DommiMOE-SP.log)
echo 81 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t81 t81.log results_DommiMOE2011/t81_DommiMOE-SP.log)
echo 81 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t81 t81.log results_DommiMOE2011/t81_DommiMOE-SP.log)
echo 81 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t81.* results_TinkerLFMM/
echo " Test 81: completed" 
