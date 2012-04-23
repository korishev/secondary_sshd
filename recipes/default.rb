#
# Cookbook Name:: secondary_sshd
# Recipe:: default
#
# Copyright 2012, Morgan Nelson
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

require_recipe 'openssh'

link "/usr/sbin/secondary_sshd" do
  to "/usr/sbin/sshd"
  type :hard
end

link "/etc/pam.d/secondary_sshd" do
  to "/etc/pam.d/sshd"
  type :hard
end

link "/etc/ssh/secondary_ssh_config" do
  to "/etc/ssh/ssh_config"
  type :hard
end

cookbook_file "/etc/ssh/secondary_sshd_config" do
  source "ssh_sshd_config"
  owner "root"
  group "root"
  variables(
    :listen_port => node["secondary_sshd"]["listen_port"]
    )
end

cookbook_file "/etc/init.d/secondary_sshd" do
  source "initd_ssh"
  owner "root"
  group "root"
end

cookbook_file "/etc/init/ssh.conf" do
  source "init_ssh.conf"
  owner "root"
  group "root"
end

cookbook_file "/etc/defaults/secondary_ssh" do
  source "defaults_secondary_ssh"
  owner "root"
  group "root"
end