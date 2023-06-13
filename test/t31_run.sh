#\!/bin/sh
# Test for TinkerLFMM: Test 31
 
rm -f lfse.in
echo " Test 31: Single Point LFMM " 
cp input/t31.xyz input/t31.key .
"$TINKERLFMMBIN"/analyze t31.xyz et > t31.log
if [ ! -f t31.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t31.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t31.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t31 t31.log results_DommiMOE2011/t31_DommiMOE-SP.log)
echo 31 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t31 t31.log results_DommiMOE2011/t31_DommiMOE-SP.log)
echo 31 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t31 t31.log results_DommiMOE2011/t31_DommiMOE-SP.log)
echo 31 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t31 t31.log results_DommiMOE2011/t31_DommiMOE-SP.log)
echo 31 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t31 t31.log results_DommiMOE2011/t31_DommiMOE-SP.log)
echo 31 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t31.* results_TinkerLFMM/
echo " Test 31: completed" 
