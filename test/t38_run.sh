#\!/bin/sh
# Test for TinkerLFMM: Test 38
 
rm -f lfse.in
echo " Test 38: Single Point LFMM " 
cp input/t38.xyz input/t38.key .
"$TINKERLFMMBIN"/analyze t38.xyz et > t38.log
if [ ! -f t38.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t38.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t38.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t38 t38.log results_DommiMOE2011/t38_DommiMOE-SP.log)
echo 38 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t38 t38.log results_DommiMOE2011/t38_DommiMOE-SP.log)
echo 38 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t38 t38.log results_DommiMOE2011/t38_DommiMOE-SP.log)
echo 38 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t38 t38.log results_DommiMOE2011/t38_DommiMOE-SP.log)
echo 38 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t38 t38.log results_DommiMOE2011/t38_DommiMOE-SP.log)
echo 38 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t38.* results_TinkerLFMM/
echo " Test 38: completed" 
