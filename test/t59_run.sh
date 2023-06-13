#\!/bin/sh
# Test for TinkerLFMM: Test 59
 
rm -f lfse.in
echo " Test 59: Single Point LFMM " 
cp input/t59.xyz input/t59.key .
"$TINKERLFMMBIN"/analyze t59.xyz et > t59.log
if [ ! -f t59.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t59.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t59.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t59 t59.log results_DommiMOE2011/t59_DommiMOE-SP.log)
echo 59 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t59 t59.log results_DommiMOE2011/t59_DommiMOE-SP.log)
echo 59 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t59 t59.log results_DommiMOE2011/t59_DommiMOE-SP.log)
echo 59 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t59 t59.log results_DommiMOE2011/t59_DommiMOE-SP.log)
echo 59 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t59 t59.log results_DommiMOE2011/t59_DommiMOE-SP.log)
echo 59 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t59.* results_TinkerLFMM/
echo " Test 59: completed" 
