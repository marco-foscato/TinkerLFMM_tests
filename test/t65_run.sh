#\!/bin/sh
# Test for TinkerLFMM: Test 65
 
rm -f lfse.in
echo " Test 65: Single Point LFMM " 
cp input/t65.xyz input/t65.key .
"$TINKERLFMMBIN"/analyze t65.xyz et > t65.log
if [ ! -f t65.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t65.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t65.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t65 t65.log results_DommiMOE2011/t65_DommiMOE-SP.log)
echo 65 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t65 t65.log results_DommiMOE2011/t65_DommiMOE-SP.log)
echo 65 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t65 t65.log results_DommiMOE2011/t65_DommiMOE-SP.log)
echo 65 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t65 t65.log results_DommiMOE2011/t65_DommiMOE-SP.log)
echo 65 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t65 t65.log results_DommiMOE2011/t65_DommiMOE-SP.log)
echo 65 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t65.* results_TinkerLFMM/
echo " Test 65: completed" 
