#\!/bin/sh
# Test for TinkerLFMM: Test 7
 
rm -f lfse.in
echo " Test 7: Single Point LFMM " 
cp input/t7.xyz input/t7.key .
"$TINKERLFMMBIN"/analyze t7.xyz et > t7.log
if [ ! -f t7.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t7.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t7.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t7 t7.log results_DommiMOE2011/t7_DommiMOE-SP.log)
echo 7 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t7 t7.log results_DommiMOE2011/t7_DommiMOE-SP.log)
echo 7 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t7 t7.log results_DommiMOE2011/t7_DommiMOE-SP.log)
echo 7 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t7 t7.log results_DommiMOE2011/t7_DommiMOE-SP.log)
echo 7 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t7 t7.log results_DommiMOE2011/t7_DommiMOE-SP.log)
echo 7 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t7.* results_TinkerLFMM/
echo " Test 7: completed" 
