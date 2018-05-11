#!/bin/zsh
#echo "Killing afl.. If zero passed it outputs to /home/test else it outputs to /Docker_Shared"
export AFL=$(ps | grep afl-fuzz)
if [ -z $AFL ]; then
    echo "ERROR"
else
    kill $(ps | grep afl-fuzz | awk '{print $1}') || echo "RIP in peace"
    echo "Copying to /Docker_Shared"; mv /home/test/afl-test/output /home/test/ ; mv /home/test/output /Docker_Shared
fi
#if [ $1 -eq 0 ]
#then
#    echo "Copy to /home/test"; mv /home/test/afl-test/output /home/test
#else
    #echo "Copying to /Docker_Shared"; mv /home/test/afl-test/output /home/test/ ; cp -r /home/test/output /Docker_Shared
#fi
