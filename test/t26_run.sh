#\!/bin/sh
# Test for TinkerLFMM: Test 26
 
rm -f lfse.in
echo " Test 26: Single Point LFMM " 
cp input/t26.xyz input/t26.key .
"$TINKERLFMMBIN"/analyze t26.xyz et > t26.log
if [ ! -f t26.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t26.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t26.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t26 t26.log results_DommiMOE2011/t26_DommiMOE-SP.log)
echo 26 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t26 t26.log results_DommiMOE2011/t26_DommiMOE-SP.log)
echo 26 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t26 t26.log results_DommiMOE2011/t26_DommiMOE-SP.log)
echo 26 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t26 t26.log results_DommiMOE2011/t26_DommiMOE-SP.log)
echo 26 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t26 t26.log results_DommiMOE2011/t26_DommiMOE-SP.log)
echo 26 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t26.* results_TinkerLFMM/
echo " Test 26: completed" 
