name "puppet-server"
default_version "3.7.3"

dependency "puppet"
dependency "puppetdb"

build do
  # Delete the unneeded docs and such
  delete "#{install_dir}/embedded/docs"
  delete "#{install_dir}/embedded/share/man"
  delete "#{install_dir}/embedded/share/doc"
  delete "#{install_dir}/embedded/share/gtk-doc"
  delete "#{install_dir}/embedded/ssl/man"
  delete "#{install_dir}/embedded/man"
  delete "#{install_dir}/embedded/info"

  # Add config files
  # etc = File.join(files_dir, "#{name}/etc")
  # sync etc, "#{install_dir}/etc"
end
