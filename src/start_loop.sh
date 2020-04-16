#!/bin/sh
#
# File: start_loop.sh
# Description: Bash executable for looping the application (for restart)
# Project: Carberry Pi
# Author: Ryan McHugh
# Year: 2020
#

mainScript(){
 out=`sudo python3 run.py $1`
}

mainScript $1


while [ 1 -eq 1 ]
do
  exit_st=`echo {$out} | grep -m 1 "exit_status"`

  if  [[ "$exit_st" == *"restart"* ]]
  then
	mainScript $1
  else
	echo "goodbye"
	break
  fi
done
