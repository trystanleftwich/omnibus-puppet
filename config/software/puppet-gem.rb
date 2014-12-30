name "puppet-gem"
default_version "3.7.3"

dependency "libxml2"
dependency "libxslt"
dependency "ruby"
dependency "rubygems"
dependency "facter-gem"
dependency "hiera-gem"
dependency "rgen-gem"
dependency "msgpack-gem"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  gem "install puppet -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"

  # Shamelessly borrowed from omnibus-chef
  auxiliary_gems = {}
  auxiliary_gems['ruby-shadow'] = '>= 0.0.0' unless aix? || windows?

  auxiliary_gems.each do |name, version|
    gem "install #{name}" \
    " --version '#{version}'" \
    " --no-ri --no-rdoc" \
    " --verbose", env: env
  end

  delete "#{install_dir}/embedded/docs"
  delete "#{install_dir}/embedded/share/man"
  delete "#{install_dir}/embedded/share/doc"
  delete "#{install_dir}/embedded/share/gtk-doc"
  delete "#{install_dir}/embedded/ssl/man"
  delete "#{install_dir}/embedded/man"
  delete "#{install_dir}/embedded/info"
end
