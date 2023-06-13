#\!/bin/sh
# Test for TinkerLFMM: Test 23
 
rm -f lfse.in
echo " Test 23: Single Point LFMM " 
cp input/t23.xyz input/t23.key .
"$TINKERLFMMBIN"/analyze t23.xyz et > t23.log
if [ ! -f t23.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t23.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t23.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t23 t23.log results_DommiMOE2011/t23_DommiMOE-SP.log)
echo 23 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t23 t23.log results_DommiMOE2011/t23_DommiMOE-SP.log)
echo 23 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t23 t23.log results_DommiMOE2011/t23_DommiMOE-SP.log)
echo 23 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t23 t23.log results_DommiMOE2011/t23_DommiMOE-SP.log)
echo 23 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t23 t23.log results_DommiMOE2011/t23_DommiMOE-SP.log)
echo 23 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t23.* results_TinkerLFMM/
echo " Test 23: completed" 
