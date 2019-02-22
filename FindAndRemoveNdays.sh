#!/bin/ksh
action=$1
dpath=$2
dtime=$3
rfile=""
rmfile(){
for  i in $(find $dpath -type f -name *.tmp -mtime +"$dtime" -exec /bin/ls {} \;)
do
rfile=$(/bin/printf "$rfile\n%s" "$i")
done
/bin/echo "`date` - File removed older than $dtime days under  $dpath:"
for f in  $(/bin/echo $rfile)
do
        if /bin/echo $f  |grep -q "$dpath" > /dev/null
        then
        /bin/echo "$i"
        /bin/rm -rf  $i
        else
        /bin/echo "check file : $f"
        fi
done
}
lsfile(){
for  i in $(find $dpath -type f -name *.tmp -mtime +"$dtime" -exec /bin/ls {} \;)
do
rfile=$(/bin/printf "$rfile\n%s" "$i")
done
/bin/echo "`date` - File list older than $dtime days under  $dpath:"
for f in  $(/bin/echo $rfile)
do
        if /bin/echo $f  |grep -q "$dpath" > /dev/null
        then
        /bin/echo  $f
        else
        /bin/echo "check file : $f"
        fi
done
}
case "$action" in
        rmfile)
                rmfile
                ;;
        lsfile)
                lsfile
                ;;
        *)
                /bin/echo $"Usage: $0 {rmfile|lsfile <Directory> <Days>}"
                exit 1
esac
