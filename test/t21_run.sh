#\!/bin/sh
# Test for TinkerLFMM: Test 21
 
rm -f lfse.in
echo " Test 21: Single Point LFMM " 
cp input/t21.xyz input/t21.key .
"$TINKERLFMMBIN"/analyze t21.xyz et > t21.log
if [ ! -f t21.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t21.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t21.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t21 t21.log results_DommiMOE2011/t21_DommiMOE-SP.log)
echo 21 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t21 t21.log results_DommiMOE2011/t21_DommiMOE-SP.log)
echo 21 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t21 t21.log results_DommiMOE2011/t21_DommiMOE-SP.log)
echo 21 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t21 t21.log results_DommiMOE2011/t21_DommiMOE-SP.log)
echo 21 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t21 t21.log results_DommiMOE2011/t21_DommiMOE-SP.log)
echo 21 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t21.* results_TinkerLFMM/
echo " Test 21: completed" 
