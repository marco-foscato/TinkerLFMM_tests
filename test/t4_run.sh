#\!/bin/sh
# Test for TinkerLFMM: Test 4
 
rm -f lfse.in
echo " Test 4: Single Point LFMM " 
cp input/t4.xyz input/t4.key .
"$TINKERLFMMBIN"/analyze t4.xyz et > t4.log
if [ ! -f t4.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t4.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t4.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t4 t4.log results_DommiMOE2011/t4_DommiMOE-SP.log)
echo 4 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t4 t4.log results_DommiMOE2011/t4_DommiMOE-SP.log)
echo 4 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t4 t4.log results_DommiMOE2011/t4_DommiMOE-SP.log)
echo 4 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t4 t4.log results_DommiMOE2011/t4_DommiMOE-SP.log)
echo 4 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t4 t4.log results_DommiMOE2011/t4_DommiMOE-SP.log)
echo 4 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t4.* results_TinkerLFMM/
echo " Test 4: completed" 
