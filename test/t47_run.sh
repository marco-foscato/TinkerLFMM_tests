#\!/bin/sh
# Test for TinkerLFMM: Test 47
 
rm -f lfse.in
echo " Test 47: Single Point LFMM " 
cp input/t47.xyz input/t47.key .
"$TINKERLFMMBIN"/analyze t47.xyz et > t47.log
if [ ! -f t47.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t47.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t47.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t47 t47.log results_DommiMOE2011/t47_DommiMOE-SP.log)
echo 47 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t47 t47.log results_DommiMOE2011/t47_DommiMOE-SP.log)
echo 47 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t47 t47.log results_DommiMOE2011/t47_DommiMOE-SP.log)
echo 47 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t47 t47.log results_DommiMOE2011/t47_DommiMOE-SP.log)
echo 47 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t47 t47.log results_DommiMOE2011/t47_DommiMOE-SP.log)
echo 47 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t47.* results_TinkerLFMM/
echo " Test 47: completed" 
