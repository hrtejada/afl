#!/bin/zsh
exitfunc(){
    trap INT
    cp -r /home/test/afl-test/output $1
    exit
}
trap "exitfunc" INT
/home/test/afl-test/afl/afl-fuzz $2 -m $3 -i /Docker_Shared/input -o /home/test/afl-test/output /Docker_Shared/bin/binary || exit
sleep 2
clear
#if [ $1 -eq 0 ]; then
#    echo 'running forever'
#    sleep infinity
#else
#    echo 'running for' $1
#    sleep $1
#    kill $(ps | grep afl-fuzz | awk '{print $1}')
#    cp -r /home/test/afl-test/output $2
#fi
trap INT

