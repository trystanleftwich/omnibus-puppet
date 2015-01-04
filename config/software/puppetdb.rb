name "puppetdb"
default_version "2.2.2"
source git: "https://github.com/puppetlabs/puppetdb.git"

dependency "puppet"
dependency "java"
dependency "postgresql"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  patch source: 'Rakefile.patch', plevel: 0
  patch source: 'install.rake.patch', plevel: 0

  build_scripts_dir = File.join(Omnibus::Config.project_root, 'build-scripts')
  lein = File.join(build_scripts_dir, 'lein')
  copy lein, "#{install_dir}/embedded/bin"

  env['LEIN_ROOT'] = 'true'
  env['PE_BUILD'] = 'true'
  env['PATH'] = "/opt/puppet/embedded/jre/bin:#{env['PATH']}"
  command "env > /tmp/env", env: env

  # First time around it gets the lein jar files
  command "lein", env: env
  # Install
  rake "package:bootstrap", env: env

  rake "install", env: env
end
