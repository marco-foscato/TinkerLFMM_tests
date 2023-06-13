#\!/bin/sh
# Test for TinkerLFMM: Test 8
 
rm -f lfse.in
echo " Test 8: Single Point LFMM " 
cp input/t8.xyz input/t8.key .
"$TINKERLFMMBIN"/analyze t8.xyz et > t8.log
if [ ! -f t8.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t8.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t8.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t8 t8.log results_DommiMOE2011/t8_DommiMOE-SP.log)
echo 8 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t8 t8.log results_DommiMOE2011/t8_DommiMOE-SP.log)
echo 8 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t8 t8.log results_DommiMOE2011/t8_DommiMOE-SP.log)
echo 8 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t8 t8.log results_DommiMOE2011/t8_DommiMOE-SP.log)
echo 8 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t8 t8.log results_DommiMOE2011/t8_DommiMOE-SP.log)
echo 8 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t8.* results_TinkerLFMM/
echo " Test 8: completed" 
