#\!/bin/sh
# Test for TinkerLFMM: Test 63
 
rm -f lfse.in
echo " Test 63: Single Point LFMM " 
cp input/t63.xyz input/t63.key .
"$TINKERLFMMBIN"/analyze t63.xyz et > t63.log
if [ ! -f t63.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t63.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t63.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t63 t63.log results_DommiMOE2011/t63_DommiMOE-SP.log)
echo 63 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t63 t63.log results_DommiMOE2011/t63_DommiMOE-SP.log)
echo 63 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t63 t63.log results_DommiMOE2011/t63_DommiMOE-SP.log)
echo 63 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t63 t63.log results_DommiMOE2011/t63_DommiMOE-SP.log)
echo 63 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t63 t63.log results_DommiMOE2011/t63_DommiMOE-SP.log)
echo 63 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t63.* results_TinkerLFMM/
echo " Test 63: completed" 
