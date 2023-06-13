#\!/bin/sh
# Test for TinkerLFMM: Test 36
 
rm -f lfse.in
echo " Test 36: Single Point LFMM " 
cp input/t36.xyz input/t36.key .
"$TINKERLFMMBIN"/analyze t36.xyz et > t36.log
if [ ! -f t36.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t36.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t36.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t36 t36.log results_DommiMOE2011/t36_DommiMOE-SP.log)
echo 36 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t36 t36.log results_DommiMOE2011/t36_DommiMOE-SP.log)
echo 36 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t36 t36.log results_DommiMOE2011/t36_DommiMOE-SP.log)
echo 36 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t36 t36.log results_DommiMOE2011/t36_DommiMOE-SP.log)
echo 36 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t36 t36.log results_DommiMOE2011/t36_DommiMOE-SP.log)
echo 36 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t36.* results_TinkerLFMM/
echo " Test 36: completed" 
