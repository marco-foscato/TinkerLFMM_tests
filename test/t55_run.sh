#\!/bin/sh
# Test for TinkerLFMM: Test 55
 
rm -f lfse.in
echo " Test 55: Single Point LFMM " 
cp input/t55.xyz input/t55.key .
"$TINKERLFMMBIN"/analyze t55.xyz et > t55.log
if [ ! -f t55.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t55.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t55.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t55 t55.log results_DommiMOE2011/t55_DommiMOE-SP.log)
echo 55 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t55 t55.log results_DommiMOE2011/t55_DommiMOE-SP.log)
echo 55 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t55 t55.log results_DommiMOE2011/t55_DommiMOE-SP.log)
echo 55 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t55 t55.log results_DommiMOE2011/t55_DommiMOE-SP.log)
echo 55 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t55 t55.log results_DommiMOE2011/t55_DommiMOE-SP.log)
echo 55 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t55.* results_TinkerLFMM/
echo " Test 55: completed" 
