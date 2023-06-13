#\!/bin/sh
# Test for TinkerLFMM: Test 25
 
rm -f lfse.in
echo " Test 25: Single Point LFMM " 
cp input/t25.xyz input/t25.key .
"$TINKERLFMMBIN"/analyze t25.xyz et > t25.log
if [ ! -f t25.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t25.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t25.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t25 t25.log results_DommiMOE2011/t25_DommiMOE-SP.log)
echo 25 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t25 t25.log results_DommiMOE2011/t25_DommiMOE-SP.log)
echo 25 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t25 t25.log results_DommiMOE2011/t25_DommiMOE-SP.log)
echo 25 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t25 t25.log results_DommiMOE2011/t25_DommiMOE-SP.log)
echo 25 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t25 t25.log results_DommiMOE2011/t25_DommiMOE-SP.log)
echo 25 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t25.* results_TinkerLFMM/
echo " Test 25: completed" 
