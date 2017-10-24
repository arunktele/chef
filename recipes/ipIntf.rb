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
# Recipe   : ipIntf
# Config files stored in chef-repo/cookbooks/cnos/files

# Configure IP interface on switch
cnos_ipIntf '1' do
  file          node['cnos']['file']
  if_name       'Ethernet1/1'
  bridge_port   node['cnos']['bridge_port']
  mtu           node['cnos']['mtu']
  ip_addr       node['cnos']['ip_addr']
  ip_prefix_len node['cnos']['ip_prefix_len']
  vrf_name      node['cnos']['vrf_name']
  admin_state 	node['cnos']['admin_state']
end
