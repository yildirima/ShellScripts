#!/bin/ksh
Offset=`ntpq  -p |grep  -e '*'|awk  '{print $9}'`
Offset=${Offset%.*}
if [ "$Offset" -lt "-60000" ] || [ "$Offset" -gt 60000 ] || [ -z  "$Offset" ]
then
        if [ ! -f /unixadmin/controlfile/ntp_offset_critical ]
        then
        /opt/OV/bin/opcmsg a=Offset o=Offset severity=Critical msg_text="`hostname`  NTP Offset Problem!" node=`hostname`
        touch  /unixadmin/controlfile/ntp_offset_critical
        fi
else
        if [ -f /unixadmin/controlfile/ntp_offset_critical ]
        then
        /opt/OV/bin/opcmsg a=Offset o=Offset severity=Normal msg_text="`hostname` NTP Offset Fixed! " node=`hostname`
        rm  -rf  /unixadmin/controlfile/ntp_offset_critical
        fi
fi
