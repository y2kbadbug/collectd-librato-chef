=begin  Not working
execute 'import_packagecloud_gpg' do
  command 'rpm --import https://packagecloud.io/gpg.key'
  not_if { File.exists?('/etc/yum.repos.d/librato_librato-collectd.repo') }
end
=end

template "/etc/yum.repos.d/librato_librato-collectd.repo" do
  source "librato_librato-collectd.repo.erb"
  mode 0440
  owner "root"
  variables ({
    :env => node.chef_environment
  })
  notifies :run, resources(:execute => "create-yum-cache"), :immediately
  notifies :create, resources(:ruby_block => "reload-internal-yum-cache"), :immediately
end

yum_package 'collectd' do
  version '5.5.0_librato23-0'
  action :install
end

service "collectd" do
  supports(
    :restart => true,
    :status => true
  )
  action [ :enable]
end

template '/opt/collectd/etc/collectd.conf.d/librato.conf' do
  source 'librato.conf.erb'
  mode '0600'
  owner 'root'
  group 'root'
  variables({
     :api_user => node['collectd_librato']['email'],
     :api_key => node['collectd_librato']['api_token']
  })
  notifies :restart, 'service[collectd]', :delayed
end

include_recipe 'collectd-librato::user'
