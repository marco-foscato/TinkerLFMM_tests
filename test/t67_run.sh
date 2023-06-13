#\!/bin/sh
# Test for TinkerLFMM: Test 67
 
rm -f lfse.in
echo " Test 67: Single Point LFMM " 
cp input/t67.xyz input/t67.key .
"$TINKERLFMMBIN"/analyze t67.xyz et > t67.log
if [ ! -f t67.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t67.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t67.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t67 t67.log results_DommiMOE2011/t67_DommiMOE-SP.log)
echo 67 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t67 t67.log results_DommiMOE2011/t67_DommiMOE-SP.log)
echo 67 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t67 t67.log results_DommiMOE2011/t67_DommiMOE-SP.log)
echo 67 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t67 t67.log results_DommiMOE2011/t67_DommiMOE-SP.log)
echo 67 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t67 t67.log results_DommiMOE2011/t67_DommiMOE-SP.log)
echo 67 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t67.* results_TinkerLFMM/
echo " Test 67: completed" 
