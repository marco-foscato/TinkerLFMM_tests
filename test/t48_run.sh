#\!/bin/sh
# Test for TinkerLFMM: Test 48
 
rm -f lfse.in
echo " Test 48: Single Point LFMM " 
cp input/t48.xyz input/t48.key .
"$TINKERLFMMBIN"/analyze t48.xyz et > t48.log
if [ ! -f t48.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t48.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t48.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t48 t48.log results_DommiMOE2011/t48_DommiMOE-SP.log)
echo 48 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t48 t48.log results_DommiMOE2011/t48_DommiMOE-SP.log)
echo 48 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t48 t48.log results_DommiMOE2011/t48_DommiMOE-SP.log)
echo 48 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t48 t48.log results_DommiMOE2011/t48_DommiMOE-SP.log)
echo 48 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t48 t48.log results_DommiMOE2011/t48_DommiMOE-SP.log)
echo 48 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t48.* results_TinkerLFMM/
echo " Test 48: completed" 
