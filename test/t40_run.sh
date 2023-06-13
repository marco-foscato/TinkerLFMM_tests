#\!/bin/sh
# Test for TinkerLFMM: Test 40
 
rm -f lfse.in
echo " Test 40: Single Point LFMM " 
cp input/t40.xyz input/t40.key .
"$TINKERLFMMBIN"/analyze t40.xyz et > t40.log
if [ ! -f t40.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t40.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t40.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t40 t40.log results_DommiMOE2011/t40_DommiMOE-SP.log)
echo 40 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t40 t40.log results_DommiMOE2011/t40_DommiMOE-SP.log)
echo 40 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t40 t40.log results_DommiMOE2011/t40_DommiMOE-SP.log)
echo 40 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t40 t40.log results_DommiMOE2011/t40_DommiMOE-SP.log)
echo 40 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t40 t40.log results_DommiMOE2011/t40_DommiMOE-SP.log)
echo 40 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t40.* results_TinkerLFMM/
echo " Test 40: completed" 
