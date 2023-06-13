#\!/bin/sh
# Test for TinkerLFMM: Test 2
 
rm -f lfse.in
echo " Test 2: Single Point LFMM " 
cp input/t2.xyz input/t2.key .
"$TINKERLFMMBIN"/analyze t2.xyz et > t2.log
if [ ! -f t2.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t2.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t2.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t2 t2.log results_DommiMOE2011/t2_DommiMOE-SP.log)
echo 2 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t2 t2.log results_DommiMOE2011/t2_DommiMOE-SP.log)
echo 2 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t2 t2.log results_DommiMOE2011/t2_DommiMOE-SP.log)
echo 2 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t2 t2.log results_DommiMOE2011/t2_DommiMOE-SP.log)
echo 2 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t2 t2.log results_DommiMOE2011/t2_DommiMOE-SP.log)
echo 2 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t2.* results_TinkerLFMM/
echo " Test 2: completed" 
