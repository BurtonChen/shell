#!/bin/bash
number=$(expr $RANDOM % 1000)
times=0
echo "来玩数字炸弹啊~~~0-999~~~，看你运气怎么样？"
startnumber=0
endnumber=999
while true
do
    read -p "请输入您猜测的数字 $startnumber~$endnumber : " int
        
    if [ $int -gt $endnumber ];
        then
        echo "您输入的数字超过 $endnumber ，请输入 $startnumber~$endnumber 范围内的数字!"
        continue
    elif [ $int -lt $startnumber ];
        then
        echo "您输入的数字低于 $starnumber ，请输入 $startnumber~$endnumber 范围内的数字!"
        continue
    elif [ $int -eq $endnumber ];
        then
        echo "请不要输入重复的最大数字 $endnumber ，请输入 $startnumber~$endnumber 范围内的数字!"
        continue
    elif [ $int -eq $startnumber ];
        then
        echo "请不要输入重复的最小数字 $startnumber ，请输入 $startnumber~$endnumber 范围内的数字!"
        continue
    else
        let times++
        if [ $int -eq $number ];
            then
            echo "恭喜您中奖了，炸弹数字是 $number "
            echo "您是第 $times 位猜对的！"
            exit 0
        elif [ $int -gt $number ] ; then
            echo "太高了！"
            endnumber=$int
        else
            echo "太低了！"
            startnumber=$int
        fi
    fi
done