#\!/bin/sh
# Test for TinkerLFMM: Test 3
 
rm -f lfse.in
echo " Test 3: Single Point LFMM " 
cp input/t3.xyz input/t3.key .
"$TINKERLFMMBIN"/analyze t3.xyz et > t3.log
if [ ! -f t3.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t3.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t3.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t3 t3.log results_DommiMOE2011/t3_DommiMOE-SP.log)
echo 3 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t3 t3.log results_DommiMOE2011/t3_DommiMOE-SP.log)
echo 3 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t3 t3.log results_DommiMOE2011/t3_DommiMOE-SP.log)
echo 3 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t3 t3.log results_DommiMOE2011/t3_DommiMOE-SP.log)
echo 3 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t3 t3.log results_DommiMOE2011/t3_DommiMOE-SP.log)
echo 3 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t3.* results_TinkerLFMM/
echo " Test 3: completed" 
