#\!/bin/sh
# Test for TinkerLFMM: Test 72
 
rm -f lfse.in
echo " Test 72: Single Point LFMM " 
cp input/t72.xyz input/t72.key .
"$TINKERLFMMBIN"/analyze t72.xyz et > t72.log
if [ ! -f t72.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t72.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t72.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t72 t72.log results_DommiMOE2011/t72_DommiMOE-SP.log)
echo 72 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t72 t72.log results_DommiMOE2011/t72_DommiMOE-SP.log)
echo 72 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t72 t72.log results_DommiMOE2011/t72_DommiMOE-SP.log)
echo 72 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t72 t72.log results_DommiMOE2011/t72_DommiMOE-SP.log)
echo 72 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t72 t72.log results_DommiMOE2011/t72_DommiMOE-SP.log)
echo 72 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t72.* results_TinkerLFMM/
echo " Test 72: completed" 
