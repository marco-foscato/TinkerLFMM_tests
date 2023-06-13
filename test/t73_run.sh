#\!/bin/sh
# Test for TinkerLFMM: Test 73
 
rm -f lfse.in
echo " Test 73: Single Point LFMM " 
cp input/t73.xyz input/t73.key .
"$TINKERLFMMBIN"/analyze t73.xyz et > t73.log
if [ ! -f t73.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t73.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t73.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t73 t73.log results_DommiMOE2011/t73_DommiMOE-SP.log)
echo 73 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t73 t73.log results_DommiMOE2011/t73_DommiMOE-SP.log)
echo 73 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t73 t73.log results_DommiMOE2011/t73_DommiMOE-SP.log)
echo 73 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t73 t73.log results_DommiMOE2011/t73_DommiMOE-SP.log)
echo 73 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t73 t73.log results_DommiMOE2011/t73_DommiMOE-SP.log)
echo 73 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t73.* results_TinkerLFMM/
echo " Test 73: completed" 
