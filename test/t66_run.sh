#\!/bin/sh
# Test for TinkerLFMM: Test 66
 
rm -f lfse.in
echo " Test 66: Single Point LFMM " 
cp input/t66.xyz input/t66.key .
"$TINKERLFMMBIN"/analyze t66.xyz et > t66.log
if [ ! -f t66.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t66.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t66.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t66 t66.log results_DommiMOE2011/t66_DommiMOE-SP.log)
echo 66 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t66 t66.log results_DommiMOE2011/t66_DommiMOE-SP.log)
echo 66 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t66 t66.log results_DommiMOE2011/t66_DommiMOE-SP.log)
echo 66 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t66 t66.log results_DommiMOE2011/t66_DommiMOE-SP.log)
echo 66 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t66 t66.log results_DommiMOE2011/t66_DommiMOE-SP.log)
echo 66 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t66.* results_TinkerLFMM/
echo " Test 66: completed" 
