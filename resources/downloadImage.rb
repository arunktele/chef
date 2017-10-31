#
# Copyright (C) 2017 Lenovo, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :protocol, String
property :serverip, String
property :srcfile, String
property :imgtype, String
property :username, String
property :passwd, String
property :vrf_name, String
property :file, String

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/system'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# The resources downloads image from the TFTP server using tftp or sftp
# Waits for the image to be downloaded and resets the switch
# Example - cnos_downloadImage 'image' do
#        	file     '<config file>'
#        	protocol 'tftp'
#        	serverip '<IP ADDRESS>'
#        	srcfile  '<IMG>'
#        	imgtype  'all'
#        	vrf_name 'management'
#	    end

action :create do
  filename = "#{ENV['HOME']}/" + file 
  switch = Connect.new(filename)
  if protocol == 'sftp'
    params = { 'protocol' => protocol,
               'serverip' => serverip,
               'srcfile' => srcfile,
               'imgtype' => imgtype,
               'username' => username,
               'passwd' => passwd,
               'vrf_name' => vrf_name }
    System.download_boot_img(switch, params)
    sleeptime = 100
    puts '\n'
    loop do
      resp = System.get_transfer_status(switch, 'download', 'image')
      if resp['status'] == 'successful' || resp['status'] == 'failed'
        break
      else
        Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
      end
      sleep sleeptime
      sleeptime = 10 if sleeptime > 11
    end
    if resp['status'] == 'successful'
      Chef::Log.info 'Transfer status >> ' + resp['status']
      params = { 'boot software' => 'standby' }
      System.put_startup_sw(switch, params)
    else
      Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end

  end

  if protocol == 'tftp'
    params = { 'protocol' => protocol,
               'serverip' => serverip,
               'srcfile' => srcfile,
               'imgtype' => imgtype,
               'vrf_name' => vrf_name }
    System.download_boot_img(switch, params)
    sleeptime = 100
    puts '\n'
    loop do
      resp = System.get_transfer_status(switch, 'download', 'image')
      if resp['status'] == 'successful' || resp['status'] == 'failed'
        break
      else
        Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
      end
      sleep sleeptime
      sleeptime /= 2 if sleeptime > 10
    end
    if resp['status'] == 'successful'
      Chef::Log.info 'Transfer status >> ' + resp['status']
      params = {
        'boot software' => 'standby'
      }
      System.put_startup_sw(switch, params)
    else
      Chef::Log.info 'Image transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end

  end
end
