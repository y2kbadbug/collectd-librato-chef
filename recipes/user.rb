template '/opt/collectd/etc/collectd.conf.d/user.conf' do
  source 'user.conf.erb'
  mode '0600'
  owner 'root'
  group 'root'
end

