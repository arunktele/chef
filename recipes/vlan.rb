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
# Cookbook : cnos
# Recipe   : vlan
# Config files stored in chef-repo/cookbooks/cnos/files

# TODO: these should be attributes, and also as examples in documentation not in the actual cookbook

# VLAN config for switch
cnos_vlan '21' do
  file 'switch.yml'
  vlan 21
  vlan_name 'vlan21'
  admin_state 'up'
  type 'create'
end

cnos_vlan '29' do
  file 'switch.yml'
  vlan 29
  vlan_name 'Vlan29'
  admin_state 'up'
  type 'create'
end

# Delete VLAN
cnos_vlan '21' do
  action :delete
  file 'switch.yml'
  vlan 21
end
