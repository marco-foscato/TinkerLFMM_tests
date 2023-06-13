#\!/bin/bash
# 
# Comparison of energy gradient
# arg-1: reference name of test (for logging purposes)
# agr-2: name of log file from TinkerLFMM
# agr-3: name of log file from DommiMOE (modified version from MF) 
#

lab=$1
logA=$2
logB=$3


#
# Get table of data from file A
#
found=0
skip=0
i=0
while read line
do
   # find beginning of table
   if [[ "$line" == *"Total energy Cartesian coordinate derivatives"* ]]
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
# Get table of data from file B
#
found=0
skip=0
i=0
while read line
do
   # find beginning of table
   if [[ "$line" == *"-- Gradient --"* ]]
   then
      found=1
      continue
   fi
   if [ "$found" == "1" ]
   then
      # ship header
      skip=$(( $skip + 1 ))
      if [ $skip -ge 2 ]
      then
         # exit if table is over
         [ -z "$line" ] && break

         # read content of table
         i=$(( $i + 1 ))
         line=$( echo $line | sed 's/[eE]+/\*10\^/g' | sed 's/[eE]-/\*10\^-/g')
         gBx[i]=$(echo $line | awk '{print $2}')
         gBy[i]=$(echo $line | awk '{print $3}')
         gBz[i]=$(echo $line | awk '{print $4}')
      fi
   fi
done < $3
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
# Compare components and get norms
#
gnormA=0.0
gnormB=0.0
maxdev=0.0
for i in `seq 1 $natomsA`
do
   # vector difference
   dgx=$( bc -l <<< "(${gAx[$i]}) - (${gBx[$i]})" )
   dgy=$( bc -l <<< "(${gAy[$i]}) - (${gBy[$i]})" )
   dgz=$( bc -l <<< "(${gAz[$i]}) - (${gBz[$i]})" )
   dgx2=$( bc -l <<< "($dgx) * ($dgx)" )
   dgy2=$( bc -l <<< "($dgy) * ($dgy)" )
   dgz2=$( bc -l <<< "($dgz) * ($dgz)" )

   gAx2=$( bc -l <<< "(${gAx[$i]}) * (${gAx[$i]})")
   gAy2=$( bc -l <<< "(${gAy[$i]}) * (${gAy[$i]})")
   gAz2=$( bc -l <<< "(${gAz[$i]}) * (${gAz[$i]})")

   gBx2=$( bc -l <<< "(${gBx[$i]}) * (${gBx[$i]})")
   gBy2=$( bc -l <<< "(${gBy[$i]}) * (${gBy[$i]})")
   gBz2=$( bc -l <<< "(${gBz[$i]}) * (${gBz[$i]})")

   gnormA=$(bc -l <<< "($gnormA) + ($gAx2) + ($gAy2) + ($gAz2)")
   gnormB=$(bc -l <<< "($gnormB) + ($gBx2) + ($gBy2) + ($gBz2)")

   # find maximum deviation
   fdgx=$( echo ${dgx#-} | awk '{printf "%20.8f", $0}')
   ismax=$(bc -l <<< "($fdgx) > ($maxdev)")
   if [[ $ismax -eq 1 ]]
   then
      maxdev=$fdgx
      maxid=$i
   fi
   fdgy=$( echo ${dgy#-} | awk '{printf "%20.8f", $0}')
   ismax=$(bc -l <<< "($fdgy) > ($maxdev)")
   if [[ $ismax -eq 1 ]]
   then
      maxdev=$fdgy
      maxid=$i
   fi
   fdgz=$( echo ${dgz#-} | awk '{printf "%20.8f", $0}')
   ismax=$(bc -l <<< "($fdgz) > ($maxdev)")
   if [[ $ismax -eq 1 ]]
   then
      maxdev=$fdgz
      maxid=$i
   fi
done

gnormA=$(bc -l <<< "sqrt($gnormA)")
gnormB=$(bc -l <<< "sqrt($gnormB)")

nnn=$( echo $natomsA | awk '{printf "%16.12f", $0}')
denom=$(bc -l <<< "sqrt($nnn)")
rmsA=$(echo "$gnormA / ($denom)" | bc -l) 
rmsB=$(echo "$gnormB / ($denom)" | bc -l)

gnormdev=$(bc -l <<< "($gnormA) - ($gnormB)")
rmsdev=$(bc -l <<< "($rmsA) - ($rmsB)")

# Report
maxdev=$(printf "%16.5e\n" "$maxdev")
gnormdev=$(printf "%16.5e\n" "$gnormdev")
rmsdev=$(printf "%16.5e\n" "$rmsdev")

# Report single line string
line=$lab" "$maxdev" "$gnormdev" "$rmsdev
echo $line
