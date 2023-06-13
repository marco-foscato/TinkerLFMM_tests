#\!/bin/sh
# Test for TinkerLFMM: Test 18
 
rm -f lfse.in
echo " Test 18: Single Point LFMM " 
cp input/t18.xyz input/t18.key .
"$TINKERLFMMBIN"/analyze t18.xyz et > t18.log
if [ ! -f t18.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t18.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t18.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t18 t18.log results_DommiMOE2011/t18_DommiMOE-SP.log)
echo 18 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t18 t18.log results_DommiMOE2011/t18_DommiMOE-SP.log)
echo 18 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t18 t18.log results_DommiMOE2011/t18_DommiMOE-SP.log)
echo 18 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t18 t18.log results_DommiMOE2011/t18_DommiMOE-SP.log)
echo 18 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t18 t18.log results_DommiMOE2011/t18_DommiMOE-SP.log)
echo 18 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t18.* results_TinkerLFMM/
echo " Test 18: completed" 
