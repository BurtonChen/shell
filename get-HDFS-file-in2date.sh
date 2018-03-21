#!/bin/bash
#This shell will download the file between two date from HDFS:/flume/kafka/$topic
#Iput download dir
read -p "Please input your topicName:" topic
#Input the date
read -p "Please input the start date (0000-00-00):" start
read -p "Please input the end date (0000-00-00)" end
#Format the date
startdate=`date -d "+0 day $start" +%Y-%m-%d`
enddate=`date -d "+1 day $end" +%Y-%m-%d`
#The direction is used to store all directorys
datadir=/home/burtondata/$topic
#Echo the date
echo "--------------------------------------"
echo "The Startdate=$start"
echo "The Enddate=$end"
echo "--------------------------------------"
#Check that the directory exists.
if [ -d $datadir ]
        then
        #if the direction exists,we should remove the file in the direction.
        echo "The $datadir directory exists,delete the data now..."
        rm -rf $datadir/*
        cd $datadir
        ls -lh
else
        #if the direction does not exists,we should create it.
        echo "The $datadir directory does not exists,create it now..."
        mkdir -p $datadir
        ls -ld $datadir
fi
#download file use while
while [[ $startdate < $enddate ]]
do
        #create a directoty to store the file
        mkdir -p $datadir/${startdate:2}
        #get hdfs file to a file that in the linux system
        hadoop fs -text /flume/kafka/$topic/${startdate:2}/* >> $datadir/${startdate:2}/${topic}_${startdate:2}
        echo "File ${topic}_${startdate:2} done."
        #check the file
        ls -lh $datadir/${startdate:2}/${topic}_${startdate:2}
        #get the next day
        startdate=`date -d "+1 day $startdate" +%Y-%m-%d`
done
echo "all done!"
