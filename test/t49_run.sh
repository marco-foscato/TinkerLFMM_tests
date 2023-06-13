#\!/bin/sh
# Test for TinkerLFMM: Test 49
 
rm -f lfse.in
echo " Test 49: Single Point LFMM " 
cp input/t49.xyz input/t49.key .
"$TINKERLFMMBIN"/analyze t49.xyz et > t49.log
if [ ! -f t49.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t49.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t49.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t49 t49.log results_DommiMOE2011/t49_DommiMOE-SP.log)
echo 49 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t49 t49.log results_DommiMOE2011/t49_DommiMOE-SP.log)
echo 49 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t49 t49.log results_DommiMOE2011/t49_DommiMOE-SP.log)
echo 49 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t49 t49.log results_DommiMOE2011/t49_DommiMOE-SP.log)
echo 49 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t49 t49.log results_DommiMOE2011/t49_DommiMOE-SP.log)
echo 49 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t49.* results_TinkerLFMM/
echo " Test 49: completed" 
