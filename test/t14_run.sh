#\!/bin/sh
# Test for TinkerLFMM: Test 14
 
rm -f lfse.in
echo " Test 14: Single Point LFMM " 
cp input/t14.xyz input/t14.key .
"$TINKERLFMMBIN"/analyze t14.xyz et > t14.log
if [ ! -f t14.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t14.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t14.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t14 t14.log results_DommiMOE2011/t14_DommiMOE-SP.log)
echo 14 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t14 t14.log results_DommiMOE2011/t14_DommiMOE-SP.log)
echo 14 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t14 t14.log results_DommiMOE2011/t14_DommiMOE-SP.log)
echo 14 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t14 t14.log results_DommiMOE2011/t14_DommiMOE-SP.log)
echo 14 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t14 t14.log results_DommiMOE2011/t14_DommiMOE-SP.log)
echo 14 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t14.* results_TinkerLFMM/
echo " Test 14: completed" 
