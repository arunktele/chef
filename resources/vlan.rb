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

property :vlan, Integer, name_property: true
property :vlan_name, String
property :admin_state, String
property :file, String
property :type, String

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/vlan'
  require 'yaml'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# This resource are used to create vlan, update and delete vlan
# Example - cnos_vlan '21' do
#		file 'switch.yml'
#		vlan 21
#		vlan_name 'vlan21'
#		admin_state 'up'
#		type 'create'
#	    end
action :create do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename)
  switch = Connect.new(param)
  if type == 'create'
    params = { 'vlan_name' => vlan_name,
               'vlan_id' => vlan,
               'admin_state' => admin_state }
    Vlan.create_vlan(switch, params)
  end
  if type == 'update'
    params = { 'vlan_name' => vlan_name,
               'vlan_id' => vlan,
               'admin_state' => admin_state }
    Vlan.update_vlan(switch, params)
  end
end

# delete vlan
action :delete do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename)
  switch = Connect.new(param)
  Vlan.delete_vlan(switch, vlan)
end
