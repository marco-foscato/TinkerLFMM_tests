#\!/bin/sh
# Test for TinkerLFMM: Test 37
 
rm -f lfse.in
echo " Test 37: Single Point LFMM " 
cp input/t37.xyz input/t37.key .
"$TINKERLFMMBIN"/analyze t37.xyz et > t37.log
if [ ! -f t37.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t37.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t37.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t37 t37.log results_DommiMOE2011/t37_DommiMOE-SP.log)
echo 37 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t37 t37.log results_DommiMOE2011/t37_DommiMOE-SP.log)
echo 37 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t37 t37.log results_DommiMOE2011/t37_DommiMOE-SP.log)
echo 37 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t37 t37.log results_DommiMOE2011/t37_DommiMOE-SP.log)
echo 37 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t37 t37.log results_DommiMOE2011/t37_DommiMOE-SP.log)
echo 37 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t37.* results_TinkerLFMM/
echo " Test 37: completed" 
