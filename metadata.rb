name              "collectd-librato"
maintainer        "Daniel Shafer"
maintainer_email  "daniel@danielshafer.name"
license           "Apache 2.0"
description       "Installs and configures collectd Librato package"
version           "0.1"
recipe            "base", "Installs and configures collectd Librato package"

%w{ redhat centos }.each do |os|
  supports os
end
