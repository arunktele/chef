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

property :file, String
property :ip_addr, String
property :if_name, String
property :bridge_port, String, default: 'yes'
property :mtu, Integer, default: 1500
property :vrf_name, String
property :admin_state, String
property :ip_prefix_len, Integer

# Defaults to the first action
default_action :create

begin
  require 'LenovoCheflib/connect'
  require 'LenovoCheflib/ip_intf'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# The resource configures the IP interface for the switch
# Example - cnos_ipIntf '1' do
#		file '<config file>'
#		if_name '<Interface>'
#		bridge_port 'yes/no'
#		mtu '1500'
#		ip_addr '0.0.0.0'
#		ip_prefix_len 0
#		vrf_name 'default'
#		admin_state 'up'
#	    end

action :create do
  filename = "#{ENV['HOME']}/" + file 
  switch = Connect.new(filename)
  params = { 'ip_addr' => ip_addr,
             'if_name' => if_name,
             'bridge_port' => bridge_port,
             'mtu' => mtu,
             'vrf_name' => vrf_name,
             'admin_state' => admin_state,
             'ip_prefix_len' => ip_prefix_len }
  resp = Ipintf.update_ip_prop_intf(switch, if_name, params)
  puts resp
end
