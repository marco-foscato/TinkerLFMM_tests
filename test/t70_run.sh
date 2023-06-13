#\!/bin/sh
# Test for TinkerLFMM: Test 70
 
rm -f lfse.in
echo " Test 70: Single Point LFMM " 
cp input/t70.xyz input/t70.key .
"$TINKERLFMMBIN"/analyze t70.xyz et > t70.log
if [ ! -f t70.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t70.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t70.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t70 t70.log results_DommiMOE2011/t70_DommiMOE-SP.log)
echo 70 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t70 t70.log results_DommiMOE2011/t70_DommiMOE-SP.log)
echo 70 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t70 t70.log results_DommiMOE2011/t70_DommiMOE-SP.log)
echo 70 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t70 t70.log results_DommiMOE2011/t70_DommiMOE-SP.log)
echo 70 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t70 t70.log results_DommiMOE2011/t70_DommiMOE-SP.log)
echo 70 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t70.* results_TinkerLFMM/
echo " Test 70: completed" 
