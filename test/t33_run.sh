#\!/bin/sh
# Test for TinkerLFMM: Test 33
 
rm -f lfse.in
echo " Test 33: Single Point LFMM " 
cp input/t33.xyz input/t33.key .
"$TINKERLFMMBIN"/analyze t33.xyz et > t33.log
if [ ! -f t33.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t33.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t33.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t33 t33.log results_DommiMOE2011/t33_DommiMOE-SP.log)
echo 33 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t33 t33.log results_DommiMOE2011/t33_DommiMOE-SP.log)
echo 33 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t33 t33.log results_DommiMOE2011/t33_DommiMOE-SP.log)
echo 33 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t33 t33.log results_DommiMOE2011/t33_DommiMOE-SP.log)
echo 33 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t33 t33.log results_DommiMOE2011/t33_DommiMOE-SP.log)
echo 33 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t33.* results_TinkerLFMM/
echo " Test 33: completed" 
