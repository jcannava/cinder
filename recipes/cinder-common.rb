#
# Cookbook Name:: cinder
# Recipe:: cinder-common
#
# Copyright 2012, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

platform_options = node["cinder"]["platform"]

platform_options["supporting_packages"].each do |pkg|
  package pkg do
    action node["osops"]["do_package_upgrades"] == true ? :upgrade : :install
    options platform_options["package_overrides"]
  end
end

cinder_conf "/etc/cinder/cinder.conf" do
	action :create
end

# now we are using mysql in the config file, ditch the original sqlite file
file "/var/lib/cinder/cinder.sqlite" do
      action :delete
end
