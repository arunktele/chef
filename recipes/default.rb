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
# Cookbook:: cnos
# Recipe:: default

# TODO: you should put a guard around this for non debian based OSes. Or add to the readme that only Debian based operating systems are supported

# Upgrade client machine
execute 'update-upgrade' do
  command 'apt-get update && apt-get upgrade -y'
  action :run
end

# Install rest-client
chef_gem 'rest-client' do
  action :install
end
require 'rest-client'

# TODO: you should really push this to rubygems
# Install LenovoCheflib
chef_gem 'LenovoCheflib' do
  action :install
end
require 'LenovoCheflib'
