#\!/bin/sh
# Test for TinkerLFMM: Test 60
 
rm -f lfse.in
echo " Test 60: Single Point LFMM " 
cp input/t60.xyz input/t60.key .
"$TINKERLFMMBIN"/analyze t60.xyz et > t60.log
if [ ! -f t60.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t60.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t60.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t60 t60.log results_DommiMOE2011/t60_DommiMOE-SP.log)
echo 60 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t60 t60.log results_DommiMOE2011/t60_DommiMOE-SP.log)
echo 60 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t60 t60.log results_DommiMOE2011/t60_DommiMOE-SP.log)
echo 60 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t60 t60.log results_DommiMOE2011/t60_DommiMOE-SP.log)
echo 60 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t60 t60.log results_DommiMOE2011/t60_DommiMOE-SP.log)
echo 60 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t60.* results_TinkerLFMM/
echo " Test 60: completed" 
