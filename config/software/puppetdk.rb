name "puppetdk"
default_version "3.7.3"

dependency "puppet"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  puppetdk_gems = {
    "rspec-hiera-puppet" => "1.0.0",
    "rspec-puppet" => "1.0.1",
    "rspec-puppet-augeas" => "0.3.0",
    "rspec-puppet-facts" => "0.2.5",
    "rspec-puppet-utils" => "2.0.4",
    "rspec-system-puppet" => "2.2.1",
    "puppet_forge" => "1.0.4",
    "puppet-syntax" => "1.4.0",
    "puppet-lint" => "1.1.0",
    "r10k" => "1.4.0",
    "sematext-metrics" => "0.0.2"
  }

  puppetdk_gems.each do |name, vers|
    gem "install #{name} -n #{install_dir}/bin --no-rdoc --no-ri -v #{vers}", :env => env
  end

  delete "#{install_dir}/embedded/docs"
  delete "#{install_dir}/embedded/share/man"
  delete "#{install_dir}/embedded/share/doc"
  delete "#{install_dir}/embedded/share/gtk-doc"
  delete "#{install_dir}/embedded/ssl/man"
  delete "#{install_dir}/embedded/man"
  delete "#{install_dir}/embedded/info"
end
