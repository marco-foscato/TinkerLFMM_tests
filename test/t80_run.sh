#\!/bin/sh
# Test for TinkerLFMM: Test 80
 
rm -f lfse.in
echo " Test 80: Single Point LFMM " 
cp input/t80.xyz input/t80.key .
"$TINKERLFMMBIN"/analyze t80.xyz et > t80.log
if [ ! -f t80.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t80.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t80.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t80 t80.log results_DommiMOE2011/t80_DommiMOE-SP.log)
echo 80 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t80 t80.log results_DommiMOE2011/t80_DommiMOE-SP.log)
echo 80 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t80 t80.log results_DommiMOE2011/t80_DommiMOE-SP.log)
echo 80 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t80 t80.log results_DommiMOE2011/t80_DommiMOE-SP.log)
echo 80 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t80 t80.log results_DommiMOE2011/t80_DommiMOE-SP.log)
echo 80 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t80.* results_TinkerLFMM/
echo " Test 80: completed" 
