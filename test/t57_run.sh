#\!/bin/sh
# Test for TinkerLFMM: Test 57
 
rm -f lfse.in
echo " Test 57: Single Point LFMM " 
cp input/t57.xyz input/t57.key .
"$TINKERLFMMBIN"/analyze t57.xyz et > t57.log
if [ ! -f t57.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t57.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t57.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t57 t57.log results_DommiMOE2011/t57_DommiMOE-SP.log)
echo 57 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t57 t57.log results_DommiMOE2011/t57_DommiMOE-SP.log)
echo 57 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t57 t57.log results_DommiMOE2011/t57_DommiMOE-SP.log)
echo 57 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t57 t57.log results_DommiMOE2011/t57_DommiMOE-SP.log)
echo 57 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t57 t57.log results_DommiMOE2011/t57_DommiMOE-SP.log)
echo 57 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t57.* results_TinkerLFMM/
echo " Test 57: completed" 
