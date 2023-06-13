#\!/bin/sh
# Test for TinkerLFMM: Test 30
 
rm -f lfse.in
echo " Test 30: Single Point LFMM " 
cp input/t30.xyz input/t30.key .
"$TINKERLFMMBIN"/analyze t30.xyz et > t30.log
if [ ! -f t30.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t30.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t30.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t30 t30.log results_DommiMOE2011/t30_DommiMOE-SP.log)
echo 30 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t30 t30.log results_DommiMOE2011/t30_DommiMOE-SP.log)
echo 30 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t30 t30.log results_DommiMOE2011/t30_DommiMOE-SP.log)
echo 30 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t30 t30.log results_DommiMOE2011/t30_DommiMOE-SP.log)
echo 30 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t30 t30.log results_DommiMOE2011/t30_DommiMOE-SP.log)
echo 30 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t30.* results_TinkerLFMM/
echo " Test 30: completed" 
