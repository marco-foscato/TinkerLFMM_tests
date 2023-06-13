#\!/bin/sh
# Test for TinkerLFMM: Test 68
 
rm -f lfse.in
echo " Test 68: Single Point LFMM " 
cp input/t68.xyz input/t68.key .
"$TINKERLFMMBIN"/analyze t68.xyz et > t68.log
if [ ! -f t68.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t68.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t68.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t68 t68.log results_DommiMOE2011/t68_DommiMOE-SP.log)
echo 68 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t68 t68.log results_DommiMOE2011/t68_DommiMOE-SP.log)
echo 68 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t68 t68.log results_DommiMOE2011/t68_DommiMOE-SP.log)
echo 68 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t68 t68.log results_DommiMOE2011/t68_DommiMOE-SP.log)
echo 68 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t68 t68.log results_DommiMOE2011/t68_DommiMOE-SP.log)
echo 68 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t68.* results_TinkerLFMM/
echo " Test 68: completed" 
