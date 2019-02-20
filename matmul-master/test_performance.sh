#!/bin/bash

shopt -s expand_aliases
alias cmd="taskset 0x1 ./matmul -n 1000 -a 0 2>>trash.txt"
datafile=testdata.txt
n=10
total_time_difference=0
echo "N=1000, run 1 time ,Renice previous command to 10">>$datafile
for ((i=1;i<=n;i++));
do

t0=$(date +%s%N)
cmd
t1=$(date +%s%N)
totaltime1=$((t1-t0))

cmd&
back_process=$!
renice 10 -p $back_process
t0=$(date +%s%N)
cmd
t1=$(date +%s%N)
totaltime2=$((t1-t0))
kill $back_process
frac=$(echo \($totaltime2-$totaltime1\)/$totaltime1 | bc -l)
total_time_difference=$(echo $total_time_difference+$frac | bc -l)
echo "The time difference of $i round:$frac" >>$datafile
done
total_time_difference=$(echo $total_time_difference/$n | bc -l)
echo "Average time differece:"  $total_time_difference >>$datafile
echo "------------------------------------" >>$datafile



alias cmd="taskset 0x1 ./matmul -n 2000 -a 0 2>>trash.txt"
echo "N=2000, run 1 time, Renice previous command to 10">>$datafile
for ((i=1;i<=n;i++));
do

t0=$(date +%s%N)
cmd
t1=$(date +%s%N)
totaltime1=$((t1-t0))

cmd&
back_process=$!
renice 10 -p $back_process
t0=$(date +%s%N)
cmd
t1=$(date +%s%N)
totaltime2=$((t1-t0))
kill $back_process
frac=$(echo \($totaltime2-$totaltime1\)/$totaltime1 | bc -l)
total_time_difference=$(echo $total_time_difference+$frac | bc -l)
echo "The time difference of $i round:$frac" >>$datafile
done
total_time_difference=$(echo $total_time_difference/$n | bc -l)
echo "Average time differece:"  $total_time_difference >>$datafile
echo "------------------------------------" >>$datafile

alias cmd="taskset 0x1 ./matmul -n 2000 -a 0 2>>trash.txt"
echo "N=2000,run 1 time, Suspend previous command">>$datafile
for ((i=1;i<=n;i++));
do

t0=$(date +%s%N)
cmd
t1=$(date +%s%N)
totaltime1=$((t1-t0))

cmd&
back_process=$!
t0=$(date +%s%N)
kill -STOP $back_process
cmd
t1=$(date +%s%N)
totaltime2=$((t1-t0))
kill $back_process
frac=$(echo \($totaltime2-$totaltime1\)/$totaltime1 | bc -l)
total_time_difference=$(echo $total_time_difference+$frac | bc -l)
echo "The time difference of $i round:$frac" >>$datafile
done
total_time_difference=$(echo $total_time_difference/$n | bc -l)
echo "Average time differece:"  $total_time_difference >>$datafile
echo "------------------------------------" >>$datafile

alias cmd="taskset 0x1 ./matmul -n 2000 -a 0 2>>trash.txt"
echo "N=2000,run 5 times, Suspend previous command">>$datafile
for ((i=1;i<=n;i++));
do

t0=$(date +%s%N)
cmd
cmd
cmd
cmd
cmd
t1=$(date +%s%N)
totaltime1=$((t1-t0))

cmd&
back_process=$!
t0=$(date +%s%N)
kill -STOP $back_process
cmd
cmd
cmd
cmd
cmd
t1=$(date +%s%N)
totaltime2=$((t1-t0))
kill $back_process
frac=$(echo \($totaltime2-$totaltime1\)/$totaltime1 | bc -l)
total_time_difference=$(echo $total_time_difference+$frac | bc -l)
echo "The time difference of $i round:$frac" >>$datafile
done
total_time_difference=$(echo $total_time_difference/$n | bc -l)
echo "Average time differece:"  $total_time_difference >>$datafile
echo "------------------------------------" >>$datafile


alias cmd="taskset 0x1 ./matmul -n 2000 -a 0 2>>trash.txt"
echo "N=2000,run 5 times, Renice previous command to 15">>$datafile
for ((i=1;i<=n;i++));
do

t0=$(date +%s%N)
cmd
cmd
cmd
cmd
cmd
t1=$(date +%s%N)
totaltime1=$((t1-t0))

cmd&
back_process=$!
renice 15 -p $back_process
t0=$(date +%s%N)
kill -STOP $back_process
cmd
cmd
cmd
cmd
cmd
t1=$(date +%s%N)
totaltime2=$((t1-t0))
kill $back_process
frac=$(echo \($totaltime2-$totaltime1\)/$totaltime1 | bc -l)
total_time_difference=$(echo $total_time_difference+$frac | bc -l)
echo "The time difference of $i round:$frac" >>$datafile
done
total_time_difference=$(echo $total_time_difference/$n | bc -l)
echo "Average time differece:"  $total_time_difference >>$datafile
echo "------------------------------------" >>$datafile
