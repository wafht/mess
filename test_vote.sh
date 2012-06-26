#!/bin/bash

postAndGet(){
	seq=$1
	candidate1=$2
	candidate2=$3
	tmp_response_file=`mktemp`
	args="seq=$seq&winner=$candidate1&loser=$candidate2"
	curl -#  --data $args --cookie 'userId=1323252403449823; email=wbafht@gmail.com; t=fqb6fftcsw4y3apbzqvn' http://www.nuomi.com/beautyPageant/vote > $tmp_response_file
	cat $tmp_response_file
}

#start

times=${1:-20}
response=''

for ((i=0;i<times;i++)) {
	seq=`echo -n $response|  grep -o -P 'seq":\d+' | grep -o -P  '\d+'`
	candidateIds=`echo -n $response | grep -o -P 'id":"\d+"' | grep -o -P '\d+'`  
	candidate1=`echo -n $candidateIds | sed -r 's/ [0-9]+//g'`
	candidate2=`echo -n $candidateIds | sed -r 's/[0-9]+ //g'`
	response=`postAndGet $seq $candidate1 $candidate2` 
	echo "INFO: seq $seq, $candidate1 PK  $candidate2 win!" 

}
