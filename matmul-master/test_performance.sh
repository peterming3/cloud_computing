#!/bin/bash

shopt -s expand_aliases
alias cmd="taskset 0x1 ./matmul -n 2000 -a 0 2>>trash.txt"
datafile=testdata.txt


t0=$(date +%s%N)

cmd
t1=$(date +%s%N)
diff=$((t1-t0))
echo "Run the test directly: "$diff>>$datafile



cmd&
renice 10 -p $!
sleep 1s
t0=$(date +%s%N)
cmd
t1=$(date +%s%N)
diff1=$((t1-t0))
echo "Run the test by terminating previous one: "$diff1>>$datafile
echo "The time difference is:" $((diff1-diff)) " ns">>$datafile
