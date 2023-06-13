#\!/bin/sh
# Test for TinkerLFMM: Test 17
 
rm -f lfse.in
echo " Test 17: Single Point LFMM " 
cp input/t17.xyz input/t17.key .
"$TINKERLFMMBIN"/analyze t17.xyz et > t17.log
if [ ! -f t17.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t17.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t17.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t17 t17.log results_DommiMOE2011/t17_DommiMOE-SP.log)
echo 17 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t17 t17.log results_DommiMOE2011/t17_DommiMOE-SP.log)
echo 17 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t17 t17.log results_DommiMOE2011/t17_DommiMOE-SP.log)
echo 17 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t17 t17.log results_DommiMOE2011/t17_DommiMOE-SP.log)
echo 17 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t17 t17.log results_DommiMOE2011/t17_DommiMOE-SP.log)
echo 17 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t17.* results_TinkerLFMM/
echo " Test 17: completed" 
