#!/bin/bash

devel_source='/opt/devel_vienna_sdk2.5';
PROC="$0"
MSG_RED='\E[1;31m'
MSG_YELOW='\E[1;33m'
MSG_GREN='\E[1;32m'
MSG_RESET='\E[0m'
top_path=$(cd $(dirname $PROC); pwd)
workspace=${top_path}/.tmp
DEBUG=0
ERROR_LOG=${workspace}/buildlog

do_pushd()
{
	local dir="$1"
	pushd "$dir" > /dev/null
}

do_popd()
{
	popd > /dev/null
}

helper()
{
cat<< USAGE
Usage: 
$0 [-c config file] [-h]

Options:
 -c             the path of source script file 
 -h             display this help and exit

Example:        
        ./$0 -c conf/devkit/devkit_v2.5.1.ini
USAGE
}

setup_env(){
	if [ -f ${devel_source} ]; then
		KERNELINC_file=$(grep "^export KERNELINC" ${devel_source} | sed 's/^.*KERNELINC=//g' ) ;
		if [ ! -d "$KERNELINC_file" ]; then
			echo -e "${MSG_RED}[ERROR]${MSG_RESET} The KERNELINC field in your devel file is wrong. Path=$KERNELINC_file" ;
			exit -1;
		fi
		KERNELSRC_file=$(grep "^export KERNELSRC" ${devel_source} | sed 's/^.*KERNELSRC=//g' ) ;
		if [ ! -d "$KERNELSRC_file" ]; then
			echo -e "${MSG_RED}[ERROR]${MSG_RESET} The KERNELSRC field in your devel file is wrong. Path=$KERNELSRC_file" ;
			exit -1 ;
		fi
	else
		echo -e "${MSG_RED}[ERROR]${MSG_RESET} The file is not found: ${MSG_YELOW}${devel_source}${MSG_RESET}" ;
		exit -1 ;
	fi	
	source ${devel_source}
}

driver_compilation(){
	local files
	local i
	local tarball
	local dirlist
	local driverdir
	local errcount

	printf "Compiling......\n"
	rm -rf ${workspace}	
	mkdir -p ${workspace}

	declare -ar files=($(find ${top_path} -maxdepth 1 -name "*.tar.gz") $(find ${top_path} -name "vpl_voc*.tar.gz"))
	if [ "${files}" = "-1" ]; then
		echo "${MSG_RED}faild\n[ERROR]${MSG_RESET} There is no drivers. \n"
		exit
	fi
	do_pushd ${workspace}
	for i in ${!files[@]}
	do
		tarball=${files[$i]}
		tar -xf ${tarball} 1>/dev/null 2>$ERROR_LOG
		if [ $? -ne 0 ]; then
			echo -e "\n${MSG_RED}[ERROR]${MSG_RESET} Fail to untar. File: ${tarball} \n"
			echo -e "=========================================== ERROR LOG ======================================================== \n"
			cat $ERROR_LOG
			echo -e "============================================================================================================== \n"
			rm -f $ERROR_LOG
			exit -1
		fi
	done
	dirlist=$(ls)
	errcount=0
	for driverdir in ${dirlist}
	do
		if [ -d ${driverdir} ]; then
			do_pushd ${driverdir}
			printf  "${driverdir}..."
			echo -e "\n------------ ${driverdir} ------------" >> $ERROR_LOG
			make 1>/dev/null 2>>$ERROR_LOG
			if [ $? -ne 0 ]; then
				echo -e "\t${MSG_RED}Fail${MSG_RESET}"
				errcount=$(expr $errcount + 1)
			else
				echo -e "\t${MSG_GREN}OK${MSG_RESET}"
			fi
			do_popd
		else
			continue
		fi
	done
	if [ $errcount -gt 0 ]; then
		echo -e "=========================================== ERROR LOG ======================================================== \n"
		cat $ERROR_LOG
		echo -e "============================================================================================================== \n"
		rm -f $ERROR_LOG
	fi	
	do_popd
	rm -rf ${workspace}
	rm -f $ERROR_LOG	
}

while getopts 'c:h' opt; do
	case $opt in
		c)      devel_source="$OPTARG";;		
		h)      helper; exit 0;;
		?)      helper; exit 1;;
	esac
done
if [ $# -lt "1" ]; then
	echo -e "Use defalut to set PATH ENV. Default: ${MSG_YELOW}$devel_source${MSG_RESET}"
else
	echo -e "Set PATH ENV by ${MSG_YELOW}${devel_source}${MSG_RESET}"
fi
setup_env
driver_compilation
