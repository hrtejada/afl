#!/bin/zsh

#Takes 3 params $1 time to run $2 output folder/shared folder and $3 souce code name

exitfunc(){
    trap INT
    cp -r /home/test/afl-test/output $2
    exit
}
trap "exitfunc" INT

/home/test/afl-test/afl/afl-gcc /Docker_Shared/source_code/${3} -o /Docker_Shared/bin/binary
chmod +x /home/test/afl-test/binary

/home/test/afl-test/afl/afl-fuzz -i /Docker_Shared/input -o /home/test/afl-test/output /Docker_Shared/bin/binary &
sleep 2
clear
echo 'running for' $1
sleep $1
kill $(ps | grep afl-fuzz | awk '{print $1}')
cp -r /home/test/afl-test/output $2
trap INT

