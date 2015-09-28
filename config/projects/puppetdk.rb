name "puppetdk"
friendly_name "Puppet Development Kit"
maintainer "Rob Lyon"
homepage "https://github.com/rlyon/omnibus-puppet"

install_dir     "/tmp/puppet"
build_version   "3.7.3"

override :ruby,     version: "2.1.5"
override :bundler,  version: "1.7.5"
override :rubygems, version: "2.4.4"
override :zlib,     version: "1.2.8"
override :puppet,   version: "3.7.3"

release_num=1

case ohai['platform_family']
when 'rhel'
  dist = File.read('/etc/redhat-release').gsub(/^.*release\ (\d+).\d+.*\ .*\n$/, '\1')
  build_iteration "#{release_num}.el#{dist}"
else
  build_iteration release_num
end

dependency "preparation"
dependency "puppetdk"

case ohai['platform_family']
when 'rhel'
  config_file "#{install_dir}/etc/logrotate.d/puppet"
  config_file "#{install_dir}/etc/puppet/puppet.conf"
  config_file "#{install_dir}/etc/sysconfig/puppet"
  config_file "#{install_dir}/etc/init.d/puppet"
when 'debian'
  # Don't do anything yet.  We'll work on the configs later
end

dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"

package :pkg do
  identifier "me.rlyon.puppetdk"
end

compress :dmg
