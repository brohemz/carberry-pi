#!/bin/bash
IFS=

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
