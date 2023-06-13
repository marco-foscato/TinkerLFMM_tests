#\!/bin/sh
# Test for TinkerLFMM: Test 54
 
rm -f lfse.in
echo " Test 54: Single Point LFMM " 
cp input/t54.xyz input/t54.key .
"$TINKERLFMMBIN"/analyze t54.xyz et > t54.log
if [ ! -f t54.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t54.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t54.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t54 t54.log results_DommiMOE2011/t54_DommiMOE-SP.log)
echo 54 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t54 t54.log results_DommiMOE2011/t54_DommiMOE-SP.log)
echo 54 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t54 t54.log results_DommiMOE2011/t54_DommiMOE-SP.log)
echo 54 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t54 t54.log results_DommiMOE2011/t54_DommiMOE-SP.log)
echo 54 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t54 t54.log results_DommiMOE2011/t54_DommiMOE-SP.log)
echo 54 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t54.* results_TinkerLFMM/
echo " Test 54: completed" 
