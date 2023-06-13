#\!/bin/sh
# Test for TinkerLFMM: Test 1
 
rm -f lfse.in
echo " Test 1: Single Point LFMM " 
cp input/t1.xyz input/t1.key .
"$TINKERLFMMBIN"/analyze t1.xyz et > t1.log
if [ ! -f t1.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t1.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t1.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t1 t1.log results_DommiMOE2011/t1_DommiMOE-SP.log)
echo 1 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t1 t1.log results_DommiMOE2011/t1_DommiMOE-SP.log)
echo 1 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t1 t1.log results_DommiMOE2011/t1_DommiMOE-SP.log)
echo 1 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t1 t1.log results_DommiMOE2011/t1_DommiMOE-SP.log)
echo 1 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t1 t1.log results_DommiMOE2011/t1_DommiMOE-SP.log)
echo 1 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t1.* results_TinkerLFMM/
echo " Test 1: completed" 
