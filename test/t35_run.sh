#\!/bin/sh
# Test for TinkerLFMM: Test 35
 
rm -f lfse.in
echo " Test 35: Single Point LFMM " 
cp input/t35.xyz input/t35.key .
"$TINKERLFMMBIN"/analyze t35.xyz et > t35.log
if [ ! -f t35.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t35.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t35.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t35 t35.log results_DommiMOE2011/t35_DommiMOE-SP.log)
echo 35 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t35 t35.log results_DommiMOE2011/t35_DommiMOE-SP.log)
echo 35 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t35 t35.log results_DommiMOE2011/t35_DommiMOE-SP.log)
echo 35 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t35 t35.log results_DommiMOE2011/t35_DommiMOE-SP.log)
echo 35 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t35 t35.log results_DommiMOE2011/t35_DommiMOE-SP.log)
echo 35 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t35.* results_TinkerLFMM/
echo " Test 35: completed" 
