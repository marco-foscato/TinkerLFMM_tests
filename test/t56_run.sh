#\!/bin/sh
# Test for TinkerLFMM: Test 56
 
rm -f lfse.in
echo " Test 56: Single Point LFMM " 
cp input/t56.xyz input/t56.key .
"$TINKERLFMMBIN"/analyze t56.xyz et > t56.log
if [ ! -f t56.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t56.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t56.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t56 t56.log results_DommiMOE2011/t56_DommiMOE-SP.log)
echo 56 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t56 t56.log results_DommiMOE2011/t56_DommiMOE-SP.log)
echo 56 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t56 t56.log results_DommiMOE2011/t56_DommiMOE-SP.log)
echo 56 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t56 t56.log results_DommiMOE2011/t56_DommiMOE-SP.log)
echo 56 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t56 t56.log results_DommiMOE2011/t56_DommiMOE-SP.log)
echo 56 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t56.* results_TinkerLFMM/
echo " Test 56: completed" 
