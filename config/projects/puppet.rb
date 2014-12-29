name "puppet"
maintainer "Fletcher Nichol"
homepage "https://github.com/fnichol/omnibus-puppet"

replace         "puppet"
install_dir     "/opt/puppet"
build_version   "3.7.3"

release_num=1
if ohai['platform_family'] == 'rhel'
  dist = File.read('/etc/redhat-release').gsub(/^.*release\ (\d+).\d+.*\ .*\n$/, '\1')
  build_iteration "#{release_num}.el#{dist}"
else
  build_iteration release_num
end

# creates required build directories
dependency "preparation"

# puppet dependencies/components
dependency "puppet-gem"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
