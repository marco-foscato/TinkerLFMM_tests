#\!/bin/bash
# 
# Comparison of energy gradient
# arg-1: reference name of test (for logging purposes)
# agr-2: name of log file from TinkerLFMM
# agr-3: name of log file from DommiMOE (version modified to report decomposition of gradient) 
#


lab=$1
logA=$2
logB=$3

#
# Function performing the analysis for a single contribution for all atoms
#

function compareGradComponent {
   # 1: pattern in file A
   # 2: name of file A
   # 3: pattern in file B
   # 4: name of file B

   #
   # Get table of data from file A
   #
   found=0
   skip=0
   i=0
   while read line
   do
      # find beginning of table
      if [[ "$line" == $1* ]]
      then
         found=1
         continue
      fi
      if [ "$found" == "1" ]
      then
          # exit if table is over
          [ -z "$line" ] && break

          # ship header
          skip=$(( $skip + 1 ))
          if [ $skip -ge 3 ] 
          then
             # read content of table
             i=$(( $i + 1 ))
             line=$( echo $line | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g')
             gAx[i]=$(echo $line | awk '{print $2}')
             gAy[i]=$(echo $line | awk '{print $3}')
             gAz[i]=$(echo $line | awk '{print $4}')
          fi
       fi
   done < $2
   natomsA=$i

   #
   # Get table of data from file B
   #
   found=0
   skip=0
   i=0
   while read line
   do
      # find beginning of table
      if [[ "$line" == *$3* ]]
      then
         found=1
         continue
      fi
      if [ "$found" == "1" ]
      then
         # exit if table is over
         [ -z "$line" ] && break

         # no header

         # read content of table
         i=$(( $i + 1 ))
         line=$( echo $line | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g')
         gBx[i]=$(echo $line | awk '{print $2}')
         gBy[i]=$(echo $line | awk '{print $3}')
         gBz[i]=$(echo $line | awk '{print $4}')
      fi
   done < $4
   natomsB=$i

   #
   # Check consistency
   #
   if [ "$natomsA" -ne "$natomsB" ]
   then
      echo " "
      echo "ERROR! Different number of atoms! $natomsA $natomsB"
      echo " "
      exit
   fi

   #
   # Deal with gradient components per each atom
   #
   str=""
   maxdev="0.0"
   maxid="0"
   maxv="0.0"
   maxvid="0"   
   for i in `seq 1 $natomsA`
   do
      # vector difference
      dgx=$( bc -l <<< "(${gAx[$i]}) - (${gBx[$i]})" )
      dgy=$( bc -l <<< "(${gAy[$i]}) - (${gBy[$i]})" )
      dgz=$( bc -l <<< "(${gAz[$i]}) - (${gBz[$i]})" )
      dgx2=$( bc -l <<< "($dgx) * ($dgx)" )
      dgy2=$( bc -l <<< "($dgy) * ($dgy)" )
      dgz2=$( bc -l <<< "($dgz) * ($dgz)" )
      v=$( bc -l <<< "sqrt(($dgx2) + ($dgy2) + ($dgz2))" )
      fv=$( echo $v | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fv) > ($maxv)")
      if [[ $ismax -eq 1 ]]
      then
         maxv=$fv
         maxvid=$i
      fi

      # find maximum deviation
      fdgx=$( echo ${dgx#-} | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fdgx) > ($maxdev)")
      if [[ $ismax -eq 1 ]]
      then
         maxdev=$fdgx
         maxid=$i
      fi
      fdgy=$( echo ${dgy#-} | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fdgy) > ($maxdev)")
      if [[ $ismax -eq 1 ]]
      then
         maxdev=$fdgy
         maxid=$i
      fi
      fdgz=$( echo ${dgz#-} | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fdgz) > ($maxdev)")
      if [[ $ismax -eq 1 ]]
      then
         maxdev=$fdgz
         maxid=$i
      fi

      # collect information for final output 
      str="$str $fv"
   done
   p1=$( echo $maxvid  | awk '{printf "%i", $0}')
   p2=$( echo $maxv    | awk '{printf "%20.5e", $0}')
   p3=$( echo $maxid   | awk '{printf "%i", $0}')
   p4=$( echo $maxdev  | awk '{printf "%20.5e", $0}')

#   echo "$p1 $p2 $p3 $p4 - $str"
   echo "$p1 $p2 $p3 $p4"
}


#
# Function performing the analysis for a single contribution for all atoms
# where for one file the contribution is actually a combination of two
# contributions.
#

function compareCombinedGradComponent {
   # 1: pattern in file A
   # 2: name of file A
   # 3: second pattern in file A2
   # 4: name of file A2
   # 5: pattern in file B
   # 6: name of file B

   #
   # Get first table of data from file A
   #
   found=0
   skip=0
   i=0
   while read line
   do
      # find beginning of table
      if [[ "$line" == $1* ]]
      then
         found=1
         continue
      fi
      if [ "$found" == "1" ]
      then
          # exit it table is over
          [ -z "$line" ] && break

          # ship header
          skip=$(( $skip + 1 ))
          if [ $skip -ge 3 ]
          then
             # read content of table
             i=$(( $i + 1 ))
             line=$( echo $line | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g')
             gAx[i]=$(echo $line | awk '{print $2}')
             gAy[i]=$(echo $line | awk '{print $3}')
             gAz[i]=$(echo $line | awk '{print $4}')
          fi
       fi
   done < $2
   natomsA=$i

   #
   # Get second table of data from file A
   #
   found=0
   skip=0
   i=0
   while read line
   do
      # find beginning of table
      if [[ "$line" == $3* ]]
      then
         found=1
         continue
      fi
      if [ "$found" == "1" ]
      then
          # exit it table is over
          [ -z "$line" ] && break

          # ship header
          skip=$(( $skip + 1 ))
          if [ $skip -ge 3 ]
          then
             # read content of table
             i=$(( $i + 1 ))
             line=$( echo $line | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g')
             gAx2[i]=$(echo $line | awk '{print $2}')
             gAy2[i]=$(echo $line | awk '{print $3}')
             gAz2[i]=$(echo $line | awk '{print $4}')
          fi
       fi
   done < $4

   #
   # Combine first and second contribution from file A
   #
   for i in `seq 1 $natomsA`
   do
      gx=$( bc -l <<< "(${gAx[$i]}) + (${gAx2[$i]})" )
      gAx[i]=$gx 
      gy=$( bc -l <<< "(${gAy[$i]}) + (${gAy2[$i]})" )
      gAy[i]=$gy 
      gz=$( bc -l <<< "(${gAz[$i]}) + (${gAz2[$i]})" )
      gAz[i]=$gz
   done

   #
   # Get table of data from file B
   #
   found=0
   skip=0
   i=0
   while read line
   do
      # find beginning of table
      if [[ "$line" == *$5* ]]
      then
         found=1
         continue
      fi
      if [ "$found" == "1" ]
      then
         # exit it table is over
         [ -z "$line" ] && break

         # no header

         # read content of table
         i=$(( $i + 1 ))
         line=$( echo $line | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g')
         gBx[i]=$(echo $line | awk '{print $2}')
         gBy[i]=$(echo $line | awk '{print $3}')
         gBz[i]=$(echo $line | awk '{print $4}')
      fi
   done < $6
   natomsB=$i

   #
   # Check consistency
   #
   if [ "$natomsA" -ne "$natomsB" ]
   then
      echo " "
      echo "ERROR! Different number of atoms!"
      echo " "
      exit
   fi

   #
   # Deal with gradient components per each atom
   #
   str=""
   maxdev="0.0"
   maxid="0"
   maxv="0.0"
   maxvid="0"
   for i in `seq 1 $natomsA`
   do
      # vector difference
      dgx=$( bc -l <<< "(${gAx[$i]}) - (${gBx[$i]})" )
      dgy=$( bc -l <<< "(${gAy[$i]}) - (${gBy[$i]})" )
      dgz=$( bc -l <<< "(${gAz[$i]}) - (${gBz[$i]})" )
      dgx2=$( bc -l <<< "($dgx) * ($dgx)" )
      dgy2=$( bc -l <<< "($dgy) * ($dgy)" )
      dgz2=$( bc -l <<< "($dgz) * ($dgz)" )
      v=$( bc -l <<< "sqrt(($dgx2) + ($dgy2) + ($dgz2))" )
      fv=$( echo $v | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fv) > ($maxv)")

      if [[ $ismax -eq 1 ]]
      then
         maxv=$fv
         maxvid=$i
      fi

      # find maximum deviation
      fdgx=$( echo ${dgx#-} | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fdgx) > ($maxdev)")
      if [[ $ismax -eq 1 ]]
      then
         maxdev=$fdgx
         maxid=$i
      fi
      fdgy=$( echo ${dgy#-} | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fdgy) > ($maxdev)")
      if [[ $ismax -eq 1 ]]
      then
         maxdev=$fdgy
         maxid=$i
      fi
      fdgz=$( echo ${dgz#-} | awk '{printf "%25.12f", $0}')
      ismax=$(bc -l <<< "($fdgz) > ($maxdev)")
      if [[ $ismax -eq 1 ]]
      then
         maxdev=$fdgz
         maxid=$i
      fi

      # collect information for final output 
      str="$str $fv"
   done
   p1=$( echo $maxvid  | awk '{printf "%i", $0}')
   p2=$( echo $maxv    | awk '{printf "%20.5e", $0}')
   p3=$( echo $maxid   | awk '{printf "%i", $0}')
   p4=$( echo $maxdev  | awk '{printf "%20.5e", $0}')

#   echo "$p1 $p2 $p3 $p4 - $str"
   echo "$p1 $p2 $p3 $p4"
}


#
# Main
#
debug=false
#debug=true
sep="   "
report=$lab" "
#compareGradComponent "eb energy component" $logA "component: str" $logB
tmp=$(compareGradComponent "eb energy component" $logA "component: str" $logB)
report="$report$sep eb $tmp"
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "ea energy component" $logA "component: ang" $logB) 
report="$report$sep ea $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "eba energy component" $logA "component: stb" $logB) 
report="$report$sep eba $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "eopb energy component" $logA "component: oop" $logB) 
report="$report$sep eopb $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "et energy component" $logA "component: tor" $logB) 
report="$report$sep et $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareCombinedGradComponent "ev energy component" $logA "esnb energy component" $logA "component: vdw" $logB) 
report="$report$sep ev $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "ec energy component" $logA "component: ele" $logB) 
report="$report$sep ec $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "es energy component" $logA "component: sol" $logB) 
report="$report$sep es $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "eg energy component" $logA "component: res" $logB) 
report="$report$sep eg $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "emolf energy component" $logA "component: Morse" $logB) 
report="$report$sep emolf $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "elllf energy component" $logA "component: llr" $logB) 
report="$report$sep elllf $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "epair energy component" $logA "component: pair" $logB) 
report="$report$sep epair $tmp"  
if $debug == true ; then echo  $tmp ; fi
tmp=$(compareGradComponent "elfse energy component" $logA "component: lfse" $logB) 
report="$report$sep elfse $tmp"  
if $debug == true ; then echo  $tmp ; fi

echo $report
