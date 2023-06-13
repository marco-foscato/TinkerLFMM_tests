#\!/bin/sh
# Test for TinkerLFMM: Test 19
 
rm -f lfse.in
echo " Test 19: Single Point LFMM " 
cp input/t19.xyz input/t19.key .
"$TINKERLFMMBIN"/analyze t19.xyz et > t19.log
if [ ! -f t19.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t19.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t19.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t19 t19.log results_DommiMOE2011/t19_DommiMOE-SP.log)
echo 19 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t19 t19.log results_DommiMOE2011/t19_DommiMOE-SP.log)
echo 19 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t19 t19.log results_DommiMOE2011/t19_DommiMOE-SP.log)
echo 19 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t19 t19.log results_DommiMOE2011/t19_DommiMOE-SP.log)
echo 19 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t19 t19.log results_DommiMOE2011/t19_DommiMOE-SP.log)
echo 19 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t19.* results_TinkerLFMM/
echo " Test 19: completed" 
