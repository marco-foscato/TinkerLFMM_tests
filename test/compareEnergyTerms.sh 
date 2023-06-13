#\!/bin/bash
# 
# Comparison of energy terms
# arg-1: reference name of test (for logging purposes)
# agr-2: name of log file from TinkerLFMM
# agr-3: name of log file from DommiMOE (modified version: writes detailed energy breakdown) 
# arg-4: name of file where to store the results

lab=$1
logA=$2
logB=$3
out=$4

function check {
   # 1: one value
   # 2: other value
   delta=$(bc -l <<< "($eA)-($eB)")
   res=$(bc -l <<< "$delta>0.0015")
   str=$(printf "\t%s%16.6f\n" "$3" "$delta")
   echo $str
}

function compareTerm {
   # 1: pattern in file A
   # 2: name of file A
   # 3: pattern in file B
   # 4: name of file B
   # 5: name of output file
 
   #
   # Get the two values of energy from the two files
   #
   lA=""
   lA=$(grep "$1" $2 | sed 's/[eE]+*/\*10\^/g' | awk '{print ( $(NF-1)) }')
   lB=""
   lB=$(grep "$3" $4 | sed 's/[eE]+*/\*10\^/g' | awk '{print $2}')
   eA="0.000000000"
   if [ "$lA" != "" ]
   then
      eA=$lA
   else
      if [ "$3" == "E(Total)" ]
      then
         echo "$3 NOT FOUND!"
         return
      fi
   fi
   eB="0.000000000"
   if [ "$lB" != "" ]
   then
      eB=$lB
   else
      if [ "$3" == "E(Total)" ]
      then
         echo "$3 NOT FOUND!"
         return  
      fi
   fi

   #
   # Compare the numbers
   #
   delta=$(bc -l <<< "($eA) - ($eB)")
   str=$(printf "\t%s%16.5e\n" "$3" "$delta")
   echo $str
#    echo $eA  $eB
}

function compareCombinedTerms {
   # 1: 1st pattern in file A
   # 2: 1st name of file A
   # 3: 2nd pattern in file A
   # 4: 2nd name of file A
   # 5: pattern in file B
   # 6: name of file B
   # 7: name of output file

   #
   # Get the two values of energy from the two files
   #
   lA=""
   lA=$(grep "$1" $2 | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g' | awk '{print ( $(NF-1)) }')
   lA2=""
   lA2=$(grep "$3" $4 | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g' | awk '{print ( $(NF-1)) }')
   lB=""
   lB=$(grep "$5" $6 | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g' | awk '{print $2}')
   eA="0.000000000"
   if [ "$lA" != "" ]
   then
      if [ "$lA2" != "" ]
      then
         eA=$( bc -l <<< "($lA) + ($lA2)")
      else
         eA=$lA
      fi
   else
      if [ "$5" == "E(Total)" ]
      then
         echo "$5 NOT FOUND!"
         return
      fi
   fi
   eB="0.000000000"
   if [ "$lB" != "" ]
   then
      eB=$lB
   else
      if [ "$5" == "E(Total)" ]
      then
         echo "$5 NOT FOUND!"
         return
      fi
   fi

   #
   # Compare the numbers
   #
   delta=$(bc -l <<< "($eA) - ($eB)")
   str=$(printf "\t%s%16.5e\n" "$5" "$delta")
   echo $str
}

 
#
# Compare energy terms one by one
#
debug=false
#debug=true
sep="   "
report=$lab" "
tmp=$(compareTerm "^ LFMM: Ligand Field "     $logA "E(LFSE)"         $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ LFMM: Morse L-M "        $logA "E(Morse)"        $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ LFMM: harmonic M-L "     $logA "E(harm)"         $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ LFMM: L-L pure rep. "    $logA "E(llrep)"        $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ LFMM: L-L rep. vdW "     $logA "E(llvdw)"        $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ LFMM: electron pairing " $logA "E(spin_pairing)" $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ Bond Stretching "        $logA "E(FF_str)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ Angle Bending "          $logA "E(FF_ang)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ Stretch-Bend "           $logA "E(FF_stb)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ Out-of-Plane Bend "      $logA "E(FF_oop)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ Torsional Angle "        $logA "E(FF_tor)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
#tmp=$(compareTerm "^ Van der Waals "          $logA "E(FF_vdw)"       $logB $report)
tmp=$(compareCombinedTerms "^ Van der Waals " $logA  "^ 12-10 van der Waals " $logA "E(FF_vdw)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ Charge-Charge "   $logA "E(FF_ele)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareTerm "^ Geometric Restraints "   $logA "E(FF_res)"       $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 
tmp=$(compareTerm "^ Total Potential Energy " $logA "E(Total)"        $logB $report)
report=$report$sep$tmp
if $debug == true ; then echo  $tmp ; fi 

echo $report

