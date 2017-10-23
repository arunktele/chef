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
property :interface, String
property :bridgeport_mode, String
property :pvid, Integer, default: 1
property :vlans, Array

# Defaults to the first action
default_action :create

begin
  require 'LenovoCheflib/connect'
  require 'LenovoCheflib/vlan_intf'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# Defaults to the first action
default_action :create

# This resource is used to configure IP interface on the switch
# Example -  cnos_ipIntf '1' do
#		file 'switch.yml'
#		if_name 'Ethernet1/1'
#		bridge_port 'yes'
#		mtu '1500'
#		ip_addr '0.0.0.0'
#		ip_prefix_len 0
#		vrf_name 'default'
#		admin_state 'up'
#           end

action :create do
  filename = "#{ENV['HOME']}/" + file 
  switch = Connect.new(filename)
  params = { 'if_name' => interface,
             'bridgeport_mode' => bridgeport_mode,
             'pvid' => pvid,
             'vlans' => vlans }
  resp = VlanIntf.update_vlan_intf(switch, interface, params)
  Chef::Log.info "\n VLAN Interface Info  "
  puts resp
end
