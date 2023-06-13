#\!/bin/sh
# Test for TinkerLFMM: Test 69
 
rm -f lfse.in
echo " Test 69: Single Point LFMM " 
cp input/t69.xyz input/t69.key .
"$TINKERLFMMBIN"/analyze t69.xyz et > t69.log
if [ ! -f t69.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t69.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t69.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t69 t69.log results_DommiMOE2011/t69_DommiMOE-SP.log)
echo 69 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t69 t69.log results_DommiMOE2011/t69_DommiMOE-SP.log)
echo 69 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t69 t69.log results_DommiMOE2011/t69_DommiMOE-SP.log)
echo 69 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t69 t69.log results_DommiMOE2011/t69_DommiMOE-SP.log)
echo 69 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t69 t69.log results_DommiMOE2011/t69_DommiMOE-SP.log)
echo 69 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t69.* results_TinkerLFMM/
echo " Test 69: completed" 
