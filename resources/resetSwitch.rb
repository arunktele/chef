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

# Defaults to the first action
default_action :create

begin
  require 'cnos-rbapi/connect'
  require 'cnos-rbapi/system'
  require 'yaml'
rescue LoadError
  Chef::Log.debug 'Failed to require rubygem'
end

# This resource is used to reset the switch after an image download
# Example :
#	cnos_resetSwitch 'reset' do
#		file     'switch.yml'
#	end

action :create do
  filename = "#{ENV['HOME']}/" + file
  param = YAML.load_file(filename) 
  switch = Connect.new(param)
  System.reset_switch(switch)
  Chef::Log.info "\n\n>>>Reset Switch " + switch.getIp + ' in progress<<<'
end
