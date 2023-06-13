#\!/bin/sh
# Test for TinkerLFMM: Test 42
 
rm -f lfse.in
echo " Test 42: Single Point LFMM " 
cp input/t42.xyz input/t42.key .
"$TINKERLFMMBIN"/analyze t42.xyz et > t42.log
if [ ! -f t42.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t42.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t42.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t42 t42.log results_DommiMOE2011/t42_DommiMOE-SP.log)
echo 42 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t42 t42.log results_DommiMOE2011/t42_DommiMOE-SP.log)
echo 42 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t42 t42.log results_DommiMOE2011/t42_DommiMOE-SP.log)
echo 42 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t42 t42.log results_DommiMOE2011/t42_DommiMOE-SP.log)
echo 42 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t42 t42.log results_DommiMOE2011/t42_DommiMOE-SP.log)
echo 42 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t42.* results_TinkerLFMM/
echo " Test 42: completed" 
