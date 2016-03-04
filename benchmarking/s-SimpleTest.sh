#!/bin/bash
OUTFILE="results/ib_send_results.txt"
INTF="tnvme40Gp1"
IB_SEND_BW="ib_send_bw $INTF --report_gbits"
KEYWORD_1="Gb/s"
KEYWORD_2="\"Send BW Test\""
GREP_0="grep $KEYWORD_2 -B 1 -A 19"
GREP_1="grep $KEYWORD_1 -A 1"
GREP_2="$GREP_1 | grep $KEYWORD_1 -v"
OUT_COMMAND_PRELUDE="$IB_SEND_BW 2>&1 | $GREP_0 &>> $OUTFILE"
OUT_COMMAND="$IB_SEND_BW 2>&1 | $GREP_2 &>> $OUTFILE"

rm $OUTFILE 2> /dev/null

COUNTER=0
UPPER_BOUND=20
while [  $COUNTER -lt $UPPER_BOUND ]; do
    if [ $COUNTER = 0 ]; then
        eval "$OUT_COMMAND_PRELUDE"
    else
        eval "$OUT_COMMAND"        
    fi

    let COUNTER=COUNTER+1 
done