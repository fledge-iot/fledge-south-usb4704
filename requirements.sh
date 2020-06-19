#!/usr/bin/env bash

##--------------------------------------------------------------------
## Copyright (c) 2019 Dianomic Systems
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##--------------------------------------------------------------------

##
## Author: Ashish Jabble
##

os_name=`(grep -o '^NAME=.*' /etc/os-release | cut -f2 -d\" | sed 's/"//g')`
os_version=`(grep -o '^VERSION_ID=.*' /etc/os-release | cut -f2 -d\" | sed 's/"//g')`
echo "Platform is ${os_name}, Version: ${os_version}"

if [[ ( $os_name == *"Red Hat"* || $os_name == *"CentOS"* ) &&  $os_version == *"7"* ]]; then
	yum -y install kernel-headers kernel-devel
	if [ `ls /lib/modules | wc -l` -gt 1 ]; then
		echo "You have multiple kernel module versions installed, this will break the Adventech"
	        echo "driver build.  Please fix the contents of /lib/modules and try again."
		exit 1
	fi
else
	sudo apt install -y unzip
fi

if [ $# -eq 1 ]; then
	DIR=$1
	if [ ! -d DIR ]; then
		mkdir -p DIR
	fi
else
	DIR=~/advantech
fi


rm -rf ${DIR}
mkdir -p ${DIR}
cd ${DIR}
echo Downloading Advantech library...

wget http://downloadt.advantech.com/download/downloadsr.aspx?File_Id=1-1WS2C1H -O linux_driver_source_4.0.2.0_64bit.run.zip
echo Unzipping driver source...
unzip linux_driver_source_4.0.2.0_64bit.run.zip
sudo chmod +x linux_driver_source_4.0.2.0_64bit.run
echo Installing driver source...
sudo ./linux_driver_source_4.0.2.0_64bit.run silent install usb4702_usb4704
echo Set the environment variable BIODAQDIR to /opt/advantech
echo export BIODAQDIR=/opt/advantech
