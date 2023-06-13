#\!/bin/sh
# Test for TinkerLFMM: Test 32
 
rm -f lfse.in
echo " Test 32: Single Point LFMM " 
cp input/t32.xyz input/t32.key .
"$TINKERLFMMBIN"/analyze t32.xyz et > t32.log
if [ ! -f t32.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t32.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t32.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t32 t32.log results_DommiMOE2011/t32_DommiMOE-SP.log)
echo 32 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t32 t32.log results_DommiMOE2011/t32_DommiMOE-SP.log)
echo 32 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t32 t32.log results_DommiMOE2011/t32_DommiMOE-SP.log)
echo 32 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t32 t32.log results_DommiMOE2011/t32_DommiMOE-SP.log)
echo 32 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t32 t32.log results_DommiMOE2011/t32_DommiMOE-SP.log)
echo 32 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t32.* results_TinkerLFMM/
echo " Test 32: completed" 
