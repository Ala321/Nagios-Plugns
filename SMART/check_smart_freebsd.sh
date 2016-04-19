#!/usr/local/bin/bash

exeSmart=/usr/local/sbin/smartctl
dev="/dev/ada0 /dev/ada1 /dev/ada2 /dev/ada3 /dev/ada4 /dev/ada5"
res=""
resCode=0;
for i in $dev; do
$exeSmart -q silent -a $i
smartstat=$(($? & 8))
 if [ $smartstat  -ne 0 ]; then
    printf  -v statStr '%x' $smartstat
    res=$res"ERR(0x$statStr) $i ";
    resCode=2
 fi
done;

if [ $resCode -eq 0 ] ; then
    echo "disks are OK"
    exit 0;
fi;
echo  $res;
exit $resCode;
