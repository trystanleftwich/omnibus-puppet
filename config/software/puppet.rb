name "puppet"
default_version "3.7.3"

dependency "augeas"
dependency "ruby"
dependency "rubygems"
dependency "facter"
dependency "hiera"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  gem "install puppet -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}", :env => env

  # Install the supporting gems
  puppet_gems = {
    "gpgme" => "2.0.8",
    "deep_merge" => "1.0.1",
    "rgen" => "0.7.0",
    "ruby-augeas" => "0.5.0",
    "msgpack" => "0.5.9",
    "json_pure" => "1.8.2",
    "hiera-puppet" => "1.0.0",
    "ruby-shadow" => "2.4.1"
  }

  puppet_gems.each do |name, vers|
    gem "install #{name} -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{vers}", :env => env
  end

  # Copy over the configuration files
  files_dir = File.join(Omnibus::Config.project_root, 'files')

  # Add the puppet_gem provider.  This needs to change, but using Dir to
  # dynamically find the appropriate directory is not working the first run
  # through.  Until it's fixed, if the ruby version goes above 2.1.x, then, the
  # gem path will also need to change.
  provider_path = File.join(
    install_dir,
    'embedded/lib/ruby/gems/2.1.0',
    "gems/puppet-#{version}",
    'lib/puppet/provider/package',
    'puppet_gem.rb'
  )
  provider = File.join(files_dir, 'providers', 'puppet_gem.rb')

  copy provider, provider_path

  # Add config files
  etc = File.join(files_dir, "etc")
  sync etc, "#{install_dir}/etc"
  ext = File.join(files_dir, "ext")
  sync ext, "#{install_dir}/ext"

  # Delete the unneeded docs and such
  delete "#{install_dir}/embedded/docs"
  delete "#{install_dir}/embedded/share/man"
  delete "#{install_dir}/embedded/share/doc"
  delete "#{install_dir}/embedded/share/gtk-doc"
  delete "#{install_dir}/embedded/ssl/man"
  delete "#{install_dir}/embedded/man"
  delete "#{install_dir}/embedded/info"
end
