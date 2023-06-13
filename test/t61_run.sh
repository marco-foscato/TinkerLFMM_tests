#\!/bin/sh
# Test for TinkerLFMM: Test 61
 
rm -f lfse.in
echo " Test 61: Single Point LFMM " 
cp input/t61.xyz input/t61.key .
"$TINKERLFMMBIN"/analyze t61.xyz et > t61.log
if [ ! -f t61.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t61.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t61.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t61 t61.log results_DommiMOE2011/t61_DommiMOE-SP.log)
echo 61 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t61 t61.log results_DommiMOE2011/t61_DommiMOE-SP.log)
echo 61 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t61 t61.log results_DommiMOE2011/t61_DommiMOE-SP.log)
echo 61 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t61 t61.log results_DommiMOE2011/t61_DommiMOE-SP.log)
echo 61 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t61 t61.log results_DommiMOE2011/t61_DommiMOE-SP.log)
echo 61 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t61.* results_TinkerLFMM/
echo " Test 61: completed" 
