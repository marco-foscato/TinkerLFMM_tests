#!/bin/bash
#
# This script is used to prepare and run all the tests sequentially.
# Tests are passed as long as there is no error returned. The
# accuracy of the calculations can be evaluated by analysing the
# summaries that are prepared in the folder results_TinkerLFMM.
#

############################## Settings ###############################

export TINKERLFMMBIN="/Users/marcof/tools/tinker_end_of_6.3/bin"

###################### Setting you usually do not change ##############
locdir=`pwd`
testdir=$locdir/test

nrgDiff=$testdir/results_TinkerLFMM/diffEnergyTerms.dat
grdDiff=$testdir/results_TinkerLFMM/diffEnergyGradient.dat
nrgDiffRel=$testdir/results_TinkerLFMM/diffEnergyTerms_relative.dat
grdDiffRel=$testdir/results_TinkerLFMM/diffEnergyGradient_relative.dat
grdDecomp=$testdir/results_TinkerLFMM/diffGradComponents.dat
optNrgDiff=$testdir/results_TinkerLFMM/diffEnergy_opt.dat
optNrgDiffRel=$testdir/results_TinkerLFMM/diffEnergy_opt_relative.dat
optGeomDiff=$testdir/results_TinkerLFMM/diffGeometries_opt.dat
optNrgDiff_2=$testdir/results_TinkerLFMM/diffEnergy_optNewton.dat
optGeomDiff_2=$testdir/results_TinkerLFMM/diffGeometries_optNewton.dat
optNrgDiff_3=$testdir/results_TinkerLFMM/diffEnergy_optOptimize.dat
optGeomDiff_3=$testdir/results_TinkerLFMM/diffGeometries_optOptimize.dat


#######################################################################
#######################################################################


if [ ! -f "$TINKERLFMMBIN/analyze" ]; then
  echo " "
  echo "ERROR: Could not find TinkerLFMM executables"
  echo "Did you configure TINKERLFMMBIN?"
  echo " "
  exit -1
fi

echo "###########################################################"
echo "#                    Testing TinkerLFMM                   #"
echo "###########################################################"

cd $testdir
rm -f $testdir/results_TinkerLFMM/*.log $testdir/results_TinkerLFMM/*.xyz $testdir/results_TinkerLFMM/*.key $nrgDiff $optNrgDiff $grdDiff $optGrdDiff $optGeomDiff $grdDecomp $optNrgDiff_2 $optNrgDiff_3 $optNrgDiff_2 $optNrgDiff_3 $nrgDiffRel $grdDiffRel $optNrgDiffRel

#Select what you want to do
#runAll=false
runAll=true

if $runAll == true
then
    #put header in summary
    echo "# 1   2   3  4  5   6  7   8  9  10 11  12 13  14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 " > $nrgDiff
    echo "id label l LFSE l mors l harm l llr l llvdw l pair l str l ang l stb l oop l tor l vdw l chg l res l TOT" >> $nrgDiff
    echo "# 1   2   3  4  5   6  7   8  9  10 11  12 13  14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32" > $optNrgDiff
    echo "id label l LFSE l mors l harm l llr l llvdw l pair l str l ang l stb l oop l tor l vdw l res l chg l TOT" >> $optNrgDiff
    echo "# 1   2   3  4  5   6  7   8  9  10 11  12 13  14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32" > $optNrgDiff_2
    echo "id label l LFSE l mors l harm l llr l llvdw l pair l str l ang l stb l oop l tor l vdw l chg l res l TOT" >> $optNrgDiff_2
    echo "# 1   2   3  4  5   6  7   8  9  10 11  12 13  14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32" > $optNrgDiff_3
    echo "id label l LFSE l mors l harm l llr l llvdw l pair l str l ang l stb l oop l tor l vdw l chg l res l TOT" >> $optNrgDiff_3
    echo "# 1    2              3        4 5" > $grdDiff
    echo "id testName MaxDevSingSomp GNormDev RMSGradDev" >> $grdDiff
    echo "# 1  2   3   " > $optGeomDiff
    echo "id testName RMSD " >> $optGeomDiff
    echo "# 1  2   3   " > $optGeomDiff_2
    echo "id testName RMSD " >> $optGeomDiff_2
    echo "# 1  2   3   " > $optGeomDiff_3
    echo "id testName RMSD " >> $optGeomDiff_3
    echo "# " > $grdDecomp
    echo "id testName eb eb eb eb eb ea ea ea ea ea eba eba eba eba eba eopb eopb eopb eopb eopb et et et et et ev ev ev ev ev ec ec ec ec ec es es es es es eg eg eg eg eg emolf emolf emolf emolf emolf elllf elllf elllf elllf elllf epair epair epair epair epair elfse elfse elfse elfse elfse" > $grdDecomp
    echo "#id testName type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev type IDmaxV maxV IDmaxDev maxDev" >> $grdDecomp


    allScripts=$(ls -lv *_run.sh  | awk '{print $NF}')
    i=0
    for scrpt in $allScripts
    do
        i=$(( $i + 1 ))
        bash $testdir/$scrpt
        if [ $? != 0 ]
        then
            echo " "
            echo " Error running test $i"
            echo " "
            exit 1
        fi
    done
else
    i=18
    bash $testdir/t$i"_run.sh"
fi

if [ $? -eq 0 ]
then
    echo " "
    echo " Testing completed! :)"
    echo " "
else
    echo " "
    echo " ERROR! Exit status != 0 from testing script."
    echo " "
fi

