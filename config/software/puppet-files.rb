name "puppetfiles"
default_version "0.0.0"

dependency "puppet"

build do
  files_dir = File.join(Omnibus::Config.project_root, 'files')
  # Add the puppet_gem provider
  puppet_gem_path = Dir["#{install_dir}/embedded/lib/ruby/gems/*/gems/puppet-*"]
  provider_path = File.join(puppet_gem_path, '/lib/puppet/provider/package', 'puppet_gem.rb')
  provider = File.join(files_dir, 'providers', 'puppet_gem.rb')
  copy provider, provider_path

  # Add config files
  etc = File.join(files_dir, 'etc')
  sync etc, "#{install_dir}/etc"
end
