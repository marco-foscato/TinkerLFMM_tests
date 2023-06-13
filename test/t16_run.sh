#\!/bin/sh
# Test for TinkerLFMM: Test 16
 
rm -f lfse.in
echo " Test 16: Single Point LFMM " 
cp input/t16.xyz input/t16.key .
"$TINKERLFMMBIN"/analyze t16.xyz et > t16.log
if [ ! -f t16.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t16.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t16.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t16 t16.log results_DommiMOE2011/t16_DommiMOE-SP.log)
echo 16 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t16 t16.log results_DommiMOE2011/t16_DommiMOE-SP.log)
echo 16 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t16 t16.log results_DommiMOE2011/t16_DommiMOE-SP.log)
echo 16 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t16 t16.log results_DommiMOE2011/t16_DommiMOE-SP.log)
echo 16 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t16 t16.log results_DommiMOE2011/t16_DommiMOE-SP.log)
echo 16 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t16.* results_TinkerLFMM/
echo " Test 16: completed" 
