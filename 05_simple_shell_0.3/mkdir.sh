#!/bin/bash
#
# mkdir command and check if /bin/mkdir still works

command="/bin/mkdir"
tmp_file="checker_tmp_file_$RANDOM"

# clean up
stop_shell
rm -f $tmp_file

# create a pseudo random file
touch $tmp_file
# empty PATH
OLDMKDIR="$MKDIR"
MKDIR=""
# send commands
$ECHO "$command" | $SHELL > $OUTPUTFILE 2> $ERROROUTPUTFILE &

# put PATH back
MKDIR="$OLDMKDIR"

# wait a little bit
$SLEEP $SLEEPSECONDS

cat $ERROROUTPUTFILE

# check the result
nmatch=`$CAT $OUTPUTFILE | $GREP -c "$tmp_file"`
if [ $nmatch -eq 1 ]; then
    print_ok
else
    print_ko
fi

# clean up
stop_shell
$RM -f $tmp_file

