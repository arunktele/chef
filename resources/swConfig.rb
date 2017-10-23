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
property :dstfile, String
property :username, String
property :passwd, String
property :vrf_name, String
property :type, String
property :file, String

# Defaults to the first action
default_action :create

begin
  require 'LenovoCheflib/connect'
  require 'LenovoCheflib/system'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# The resources downloads/uploads switch config from the TFTP server using tftp or sftp
# Example - cnos_swConfig 'config' do
#		file '<config file>'
#		type 'download/upload'
#		protocol 'tftp/sftp'
#		serverip '192.168.1.1'
#		srcfile '<switch.conf>'
#		dstfile 'running_config/startup_config'
#		vrf_name 'management'
#	    end

action :create do
  filename = '/home/chef/' + file  # TODO: having this hard coded for /home/chef is a bad idea, most users use _their_ home directory
  switch = Connect.new(filename)
  if type == 'download'
    if protocol == 'tftp'
      params = { 'protocol' => protocol,
                 'serverip' => serverip,
                 'srcfile' => srcfile,
                 'dstfile' => dstfile,
                 'vrf_name' => vrf_name }
      System.download_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'download', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    else
      params = {
        'protocol' => protocol,
        'serverip' => serverip,
        'srcfile' => srcfile,
        'dstfile' => dstfile,
        'username' => username,
        'passwd' => passwd,
        'vrf_name' => vrf_name }
      System.download_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'upload', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end
  end

  if type == 'upload'
    if protocol == 'tftp'
      params = { 'protocol' => protocol,
                 'serverip' => serverip,
                 'srcfile' => srcfile,
                 'dstfile' => dstfile,
                 'vrf_name' => vrf_name }
      System.upload_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'upload', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    else
      parrams = { 'protocol' => protocol,
                  'serverip' => serverip,
                  'srcfile' => srcfile,
                  'dstfile' => dstfile,
                  'username' => username,
                  'passwd' => passwd,
                  'vrf_name' => vrf_name }
      System.upload_sw_config(switch, params)
      sleeptime = 5
      puts '\n'
      loop do
        resp = System.get_transfer_status(switch, 'upload', 'running_config')
        if resp['status'] == 'successful' || resp['status'] == 'failed'
          break
        else
          Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
        end
        sleep sleeptime
      end
      Chef::Log.info 'Config transfer status ' + switch.getIp + ' >>>> ' + resp['status']
    end
  end
end
