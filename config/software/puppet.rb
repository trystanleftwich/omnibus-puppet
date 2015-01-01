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

  puppet_gems = {
    "gpgme" => "2.0.8",
    "deep_merge" => "1.0.1",
    "rgen" => "0.7.0",
    "ruby-augeas" => "0.5.0",
    "msgpack" => "0.5.9",
    "json_pure" => "1.8.1",
    "hiera-puppet" => "1.0.0",
    "ruby-shadow" => "2.4.1"
  }

  puppet_gems.each do |name, vers|
    gem "install #{name} -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{vers}", :env => env
  end

  delete "#{install_dir}/embedded/docs"
  delete "#{install_dir}/embedded/share/man"
  delete "#{install_dir}/embedded/share/doc"
  delete "#{install_dir}/embedded/share/gtk-doc"
  delete "#{install_dir}/embedded/ssl/man"
  delete "#{install_dir}/embedded/man"
  delete "#{install_dir}/embedded/info"
end
