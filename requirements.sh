#!/usr/bin/env bash

##--------------------------------------------------------------------
## Copyright (c) 2019 Dianomic Systems Inc.
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

driver_version='4.0.3.0_64bit'

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
# From version 4.0.3.0 the downloaded file is not a zip file.
wget https://driver-libs.s3.amazonaws.com/advantech/linux_driver_source_${driver_version}.run
# sudo apt install -y unzip
# echo Unzipping driver source...
# unzip linux_driver_source_${driver_version}.run.zip
sudo chmod +x linux_driver_source_${driver_version}.run
echo Installing driver source...
sudo ./linux_driver_source_${driver_version}.run silent install usb4702_usb4704
echo Set the environment variable BIODAQDIR to /opt/advantech
echo export BIODAQDIR=/opt/advantech
