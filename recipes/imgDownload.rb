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
# Recipe   : imgDownload
# Config files stored in chef-repo/cookbooks/cnos/files

#transfer Config files for switches to client
cookbook_file '/home/chef/switch.yml' do
        source 'switch.yml'
        action :create
end

#Download Image from TFTP server
cnos_downloadImage 'image' do
	file     'switch.yml'
	protocol 'tftp'
	serverip '192.168.1.1'
	srcfile  'G8296-CNOS-10.4.2.0.img'	
	imgtype  'all'
	vrf_name 'management'
end

#Reset the switch
cnos_resetSwitch 'reset' do
	file     'switch.yml'
end
