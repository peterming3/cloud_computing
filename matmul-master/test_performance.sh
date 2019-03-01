#!/bin/bash


shopt -s expand_aliases
up=3000
for ((N=1000;N<=up;N=N+500));
do
alias cmd="taskset 0x1 ./matmul -n $N -a 0 2>>trash.txt"
datafile=testdata2.txt
n=1
total_time_difference=0
echo "N=$N, run 1 time ,Renice previous command to 15">>$datafile
for ((i=1;i<=n;i++));
do

t0=$(date +%s%N)
taskset 0x1 ./matmul -n $N -a 0 2>>trash.txt
t1=$(date +%s%N)
totaltime1=$((t1-t0))

taskset 0x1 ./matmul -n 2000 -a 0 2>>trash.txt&
back_process=$!
sleep 1;
ps -p $back_process -o %mem,%cpu >>$datafile

renice 15 -p $back_process

t0=$(date +%s%N)
taskset 0x1 ./matmul -n $N -a 0 2>>trash.txt
t1=$(date +%s%N)
totaltime2=$((t1-t0))
kill $back_process
local_time_difference=$(echo \($totaltime2-$totaltime1\)/1000000 | bc -l)
total_time_difference=$(echo $total_time_difference+$local_time_difference | bc -l)
echo "The time difference of $i round:$local_time_difference" >>$datafile
done

total_time_difference=$(echo $total_time_difference/$n | bc -l)
echo "Average time differece:"  $total_time_difference >>$datafile
echo "------------------------------------" >>$datafile

done


# for ((N=1000;N<=up;N=N+500));
# do
# shopt -s expand_aliases
# alias cmd="taskset 0x1 ./matmul -n $N -a 0 2>>trash.txt"
# datafile=testdata2.txt
# n=10
# total_time_difference=0
# echo "N=$N, run 1 time ,stop previous process">>$datafile
# for ((i=1;i<=n;i++));
# do
# 
# t0=$(date +%s%N)
# taskset 0x1 ./matmul -n $N -a 0 2>>trash.txt
# t1=$(date +%s%N)
# totaltime1=$((t1-t0))
# 
# taskset 0x1 ./matmul -n $N -a 0 2>>trash.txt&
# back_process=$!
# x=$(ps -p $back_process -o %mem,%cpu)
# echo "The memory usage of $i round:$x" >>$datafile
# t0=$(date +%s%N)
# kill -stop $back_process
# taskset 0x1 ./matmul -n $N -a 0 2>>trash.txt
# t1=$(date +%s%N)
# totaltime2=$((t1-t0))
# kill $back_process
# local_time_difference=$(echo \($totaltime2-$totaltime1\)/1000 | bc -l)
# total_time_difference=$(echo $total_time_difference+$local_time_difference | bc -l)
# echo "The time difference of $i round:$local_time_difference" >>$datafile
# done
# total_time_difference=$(echo $total_time_difference/$n | bc -l)
# echo "Average time differece:"  $total_time_difference >>$datafile
# echo "------------------------------------" >>$datafile
# 
# done
