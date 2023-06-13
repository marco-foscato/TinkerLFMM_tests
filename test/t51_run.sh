#\!/bin/sh
# Test for TinkerLFMM: Test 51
 
rm -f lfse.in
echo " Test 51: Single Point LFMM " 
cp input/t51.xyz input/t51.key .
"$TINKERLFMMBIN"/analyze t51.xyz et > t51.log
if [ ! -f t51.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t51.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t51.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t51 t51.log results_DommiMOE2011/t51_DommiMOE-SP.log)
echo 51 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t51 t51.log results_DommiMOE2011/t51_DommiMOE-SP.log)
echo 51 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t51 t51.log results_DommiMOE2011/t51_DommiMOE-SP.log)
echo 51 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t51 t51.log results_DommiMOE2011/t51_DommiMOE-SP.log)
echo 51 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t51 t51.log results_DommiMOE2011/t51_DommiMOE-SP.log)
echo 51 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t51.* results_TinkerLFMM/
echo " Test 51: completed" 
