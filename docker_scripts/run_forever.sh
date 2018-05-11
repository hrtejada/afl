#!/bin/zsh
#
# Accpets either 0(qemu) or 1(source code) as a param
# /Docker_Shared is the name of the shared folder
# /Docker_Shared must have 


exitfunc(){
    trap INT
    cp -r /home/test/afl-test/output $2 
    exit
}
trap "exitfunc" INT
echo 'Accepts one argument 0(qemu) or 1(source) needs /Docker_Shared as the shared folder between host-toolbox-container'
sleep 4
clear
if [ $1 -eq 0 ]
then
    echo 'Qemu Mode'
    /home/test/afl-test/afl/afl-fuzz -Q -i /Docker_Shared/input -o /home/test/afl-test/output /Docker_Shared/bin/binary
    #/home/test/afl-test/afl/afl-fuzz -Q -i /home/test/afl-test/input -o /home/test/afl-test/output /home/test/afl-test/test
else
    echo 'Source Code Mode'
#    /home/test/afl-test/afl/afl-gcc /Docker_Shared/source_code/source_code.c -o /Docker_Shared/bin/binary
#    chmod +x /Docker_Shared/bin/binary
#    /home/test/afl-test/afl/afl-fuzz -i /Docker_Shared/input -o /home/test/afl-test/output /Docker_Shared/bin/binary

    /home/test/afl-test/afl/afl-gcc /home/test/afl-test/test.c -o /home/test/afl-test/binary
    chmod +x /home/test/afl-test/binary
    /home/test/afl-test/afl/afl-fuzz -i /home/test/afl-test/input -o /home/test/afl-test/output /home/test/afl-test/binary

fi

trap INT



