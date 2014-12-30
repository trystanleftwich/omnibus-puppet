name "puppet"
maintainer "Fletcher Nichol"
homepage "https://github.com/fnichol/omnibus-puppet"

replace         "puppet"
install_dir     "/opt/puppet"
build_version   "3.7.3"

override :ruby,     version: "2.1.5"
override :bundler,  version: "1.7.5"
override :rubygems, version: "2.4.4"
override :zlib,     version: "1.2.8"

release_num=1
if ohai['platform_family'] == 'rhel'
  dist = File.read('/etc/redhat-release').gsub(/^.*release\ (\d+).\d+.*\ .*\n$/, '\1')
  build_iteration "#{release_num}.el#{dist}"
else
  build_iteration release_num
end

dependency "preparation"
dependency "puppet-gem"
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
