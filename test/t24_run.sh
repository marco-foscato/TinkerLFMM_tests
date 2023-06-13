#\!/bin/sh
# Test for TinkerLFMM: Test 24
 
rm -f lfse.in
echo " Test 24: Single Point LFMM " 
cp input/t24.xyz input/t24.key .
"$TINKERLFMMBIN"/analyze t24.xyz et > t24.log
if [ ! -f t24.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t24.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t24.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t24 t24.log results_DommiMOE2011/t24_DommiMOE-SP.log)
echo 24 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t24 t24.log results_DommiMOE2011/t24_DommiMOE-SP.log)
echo 24 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t24 t24.log results_DommiMOE2011/t24_DommiMOE-SP.log)
echo 24 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t24 t24.log results_DommiMOE2011/t24_DommiMOE-SP.log)
echo 24 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t24 t24.log results_DommiMOE2011/t24_DommiMOE-SP.log)
echo 24 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t24.* results_TinkerLFMM/
echo " Test 24: completed" 
