#\!/bin/sh
# Test for TinkerLFMM: Test 52
 
rm -f lfse.in
echo " Test 52: Single Point LFMM " 
cp input/t52.xyz input/t52.key .
"$TINKERLFMMBIN"/analyze t52.xyz et > t52.log
if [ ! -f t52.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t52.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t52.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t52 t52.log results_DommiMOE2011/t52_DommiMOE-SP.log)
echo 52 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t52 t52.log results_DommiMOE2011/t52_DommiMOE-SP.log)
echo 52 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t52 t52.log results_DommiMOE2011/t52_DommiMOE-SP.log)
echo 52 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t52 t52.log results_DommiMOE2011/t52_DommiMOE-SP.log)
echo 52 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t52 t52.log results_DommiMOE2011/t52_DommiMOE-SP.log)
echo 52 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t52.* results_TinkerLFMM/
echo " Test 52: completed" 
