# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end

execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "curl"
package "ntp"

cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end

execute 'ntp_restart' do
  command 'service ntp restart'
end

# My Configuration

app_dir = "/home/ubuntu/project"

directory app_dir do
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
end

execute 'install nodejs using snap' do
    command 'sudo snap install node --classic --channel=10'
    cwd     app_dir
    user    "ubuntu"
end

apt_repository 'mongodb' do
  uri 'https://repo.mongodb.org/apt/ubuntu'
  arch         'amd64'
  distribution 'xenial/mongodb-org/4.0'
  key '9DA31620334BD75D9DCB49F368818C72E52529D4'
  keyserver 'keyserver.ubuntu.com'
  components   ['multiverse']
  action :add
end

execute 'apt_update' do
  command 'sudo apt-get update'
end

package %w(mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools) do
  version [ '4.0.9', '4.0.9', '4.0.9', '4.0.9', '4.0.9']
end




# execute 'install pipenv' do
#     command 'sudo -H pip install --user pipenv'
#     cwd     app_dir
#     user    "ubuntu"
# end

# execute 'create pipenv path' do
#   command   'export PATH=$PATH:/home/ubuntu/.local'
#   cwd       app_dir
#   user      "ubuntu"
# end

# execute 'test python' do
#   command   'python --version'
#   cwd       app_dir
#   user      "ubuntu"
# end