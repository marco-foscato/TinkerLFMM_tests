#\!/bin/sh
# Test for TinkerLFMM: Test 29
 
rm -f lfse.in
echo " Test 29: Single Point LFMM " 
cp input/t29.xyz input/t29.key .
"$TINKERLFMMBIN"/analyze t29.xyz et > t29.log
if [ ! -f t29.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t29.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t29.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t29 t29.log results_DommiMOE2011/t29_DommiMOE-SP.log)
echo 29 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t29 t29.log results_DommiMOE2011/t29_DommiMOE-SP.log)
echo 29 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t29 t29.log results_DommiMOE2011/t29_DommiMOE-SP.log)
echo 29 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t29 t29.log results_DommiMOE2011/t29_DommiMOE-SP.log)
echo 29 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t29 t29.log results_DommiMOE2011/t29_DommiMOE-SP.log)
echo 29 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t29.* results_TinkerLFMM/
echo " Test 29: completed" 
