#\!/bin/sh
# Test for TinkerLFMM: Test 77
 
rm -f lfse.in
echo " Test 77: Single Point LFMM " 
cp input/t77.xyz input/t77.key .
"$TINKERLFMMBIN"/analyze t77.xyz et > t77.log
if [ ! -f t77.log ]
then
    echo ERROR! No output produced
    exit 1
else 
    grep -q "Normal Termination" t77.log
    if [ $? != 0 ]
    then
        echo ERROR! Tinker did not terminate normally
        exit 2
    fi
fi
#grep -q "0" t77.log
#if [ $? != 0 ] ; then
#echo ERROR! Check err-3
#exit 3
#fi
# Compare energy terms
result=$(./compareEnergyTerms_relative.sh t77 t77.log results_DommiMOE2011/t77_DommiMOE-SP.log)
echo 77 $result >> results_TinkerLFMM/diffEnergyTerms_relative.dat 
result=$(./compareEnergyGradient_relative.sh t77 t77.log results_DommiMOE2011/t77_DommiMOE-SP.log)
echo 77 $result >> results_TinkerLFMM/diffEnergyGradient_relative.dat  
result=$(\.\/compareEnergyTerms\.sh t77 t77.log results_DommiMOE2011/t77_DommiMOE-SP.log)
echo 77 $result >> results_TinkerLFMM/diffEnergyTerms.dat
result=$(\.\/compareEnergyGradient\.sh t77 t77.log results_DommiMOE2011/t77_DommiMOE-SP.log)
echo 77 $result >> results_TinkerLFMM/diffEnergyGradient.dat
result=$(\.\/compareGradDecomposition\.sh t77 t77.log results_DommiMOE2011/t77_DommiMOE-SP.log)
echo 77 $result >> results_TinkerLFMM/diffGradComponents.dat
 
mv t77.* results_TinkerLFMM/
echo " Test 77: completed" 
