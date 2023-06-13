#\!/bin/sh
# Test for TinkerLFMM: Test 41
 
rm -f lfse.in
echo " Test 41: Single Point LFMM " 
cp input/t41.xyz input/t41.key .
"$TINKERLFMMBIN"/analyze t41.xyz et > t41.log
if [ ! -f t41.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t41.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t41.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t41 t41.log results_DommiMOE2011/t41_DommiMOE-SP.log)
echo 41 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t41 t41.log results_DommiMOE2011/t41_DommiMOE-SP.log)
echo 41 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t41 t41.log results_DommiMOE2011/t41_DommiMOE-SP.log)
echo 41 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t41 t41.log results_DommiMOE2011/t41_DommiMOE-SP.log)
echo 41 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t41 t41.log results_DommiMOE2011/t41_DommiMOE-SP.log)
echo 41 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t41.* results_TinkerLFMM/
echo " Test 41: completed" 
