##
## Copyright (C) 2017 Lenovo, Inc.
## Licensed under the Apache License, Version 2.0 (the "License"); 
## you may not use this file except in compliance with the License. 
## You may obtain a copy of the License at 
##       http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software 
## distributed under the License is distributed on an "AS IS" BASIS, 
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and 
## limitations under the License.
##
# Cookbook : cnos
# Recipe   : configDownload
# Config files stored in chef-repo/cookbooks/cnos/files


#Download Config as running config from TFTP server
cnos_swConfig 'config' do
	file 'switch.yml'
	type 'download'
	protocol 'tftp'
	serverip '192.168.1.1'
	srcfile 'switch.conf'
	dstfile 'running_config'
	vrf_name 'management'
end
