#!/bin/bash
#####################################################################
# Title   : Check Server Process Status
# Author  : LiChun
# Email   : gengyuntuo@163.com
# Describe: Nothing
#####################################################################
WORK_DIR=$PWD
FILE_PATH=$1
FILE_NAME=`basename "$1"`
cd `dirname $BASH_SOURCE`

#################################################
# FUNCTIONS DEFINITION
#################################################
# show usage message
function showUsage() {
	echo "Usage : $0 [path] | -h"
	echo "  Option:"
	echo "    * path:the config file of host-process-mapping"
	echo "    * -h  :show this help message"
	echo ""
	echo "  Config File Describe:"
	echo "    * comment: every line start with '#' is a comment line, the program will neglect this line."
	echo "    * config line format:"
	echo "         [host] [username] [field] [value] [processname]"
	echo "         host        : the ip or hostname of the host"
	echo "         username    : username of the host"
	echo "         field       : the key words fo the process"
	echo "         value       : the value of expected"
	echo "         processname : the process name"
	echo ""
}
# show error message
function showErrorMsg() {
    echo -e "\E[1;31m$1 \E[0m"
    showUsage
    exit
}
# check process status
function checkProcess() {
    ps -ef | grep "$1" | grep -v grep | wc -l
}

# finish the work
function process() {
    awk -f ./checkServerStatus.awk $1
}

#################################################
# The Main Program
#################################################
# check parameter
if [ "" == "$1" ]; then
	showErrorMsg "Please input the path of the config file."
elif [ "-h" == "$1" ]; then
    showUsage
    exit
elif [ ! -f $WORK_DIR/$FILE_NAME ]; then
	showErrorMsg "The config file($WORK_DIR/$FILE_NAME) don't exists"
fi
# process
process $WORK_DIR/$FILE_NAME
