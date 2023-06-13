#\!/bin/sh
# Test for TinkerLFMM: Test 22
 
rm -f lfse.in
echo " Test 22: Single Point LFMM " 
cp input/t22.xyz input/t22.key .
"$TINKERLFMMBIN"/analyze t22.xyz et > t22.log
if [ ! -f t22.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t22.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t22.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t22 t22.log results_DommiMOE2011/t22_DommiMOE-SP.log)
echo 22 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t22 t22.log results_DommiMOE2011/t22_DommiMOE-SP.log)
echo 22 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t22 t22.log results_DommiMOE2011/t22_DommiMOE-SP.log)
echo 22 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t22 t22.log results_DommiMOE2011/t22_DommiMOE-SP.log)
echo 22 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t22 t22.log results_DommiMOE2011/t22_DommiMOE-SP.log)
echo 22 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t22.* results_TinkerLFMM/
echo " Test 22: completed" 
