#\!/bin/sh
# Test for TinkerLFMM: Test 6
 
rm -f lfse.in
echo " Test 6: Single Point LFMM " 
cp input/t6.xyz input/t6.key .
"$TINKERLFMMBIN"/analyze t6.xyz et > t6.log
if [ ! -f t6.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t6.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t6.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t6 t6.log results_DommiMOE2011/t6_DommiMOE-SP.log)
echo 6 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t6 t6.log results_DommiMOE2011/t6_DommiMOE-SP.log)
echo 6 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t6 t6.log results_DommiMOE2011/t6_DommiMOE-SP.log)
echo 6 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t6 t6.log results_DommiMOE2011/t6_DommiMOE-SP.log)
echo 6 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t6 t6.log results_DommiMOE2011/t6_DommiMOE-SP.log)
echo 6 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t6.* results_TinkerLFMM/
echo " Test 6: completed" 
