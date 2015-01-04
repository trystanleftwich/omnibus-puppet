# Task to install puppetdb's files into a target directory
#
# DESTDIR is defined in the top-level Rakefile
# JAR_FILE is defined in the ext/tar.rake file
#
desc "Install PuppetDB (DESTDIR and PE_BUILD optional arguments)"
task :install => [  JAR_FILE  ] do
  unless File.exists?("ext/files/config.ini")
    Rake::Task[:template].invoke
  end

  require 'facter'
  raise "Oh damn. You need a newer facter or better facts. Facter version: #{Facter.version}" if Facter.value(:osfamily).nil?
  @osfamily = Facter.value(:osfamily).downcase
  mkdir_p "#{@install_dir}"
  mkdir_p "#{@config_dir}"
  # mkdir_p "#{@config_dir}/.."
  mkdir_p "#{@log_dir}"
  # mkdir_p "#{@install_dir}/etc/init.d/"
  mkdir_p "#{@lib_dir}"
  mkdir_p "#{@libexec_dir}"
  # mkdir_p "#{@install_dir}/etc/logrotate.d/"
  # ln_sf @config_dir, "#{DESTDIR}/#{@lib_dir}/config"
  # ln_sf @log_dir, "#{DESTDIR}/#{@install_dir}/log"

  mkdir_p "#{@lib_dir}/state"
  mkdir_p "#{@lib_dir}/db"
  mkdir_p "#{@lib_dir}/mq"
  # mkdir_p "#{@install_dir}/etc/puppetdb"

  cp_p JAR_FILE, @install_dir
  cp_pr "ext/files/config.ini", @config_dir
  cp_pr "ext/files/database.ini", @config_dir
  cp_pr "ext/files/jetty.ini", @config_dir
  cp_pr "ext/files/repl.ini", @config_dir
  cp_pr "ext/files/puppetdb.logrotate", "/opt/puppet/etc/logrotate.d/#{@name}"
  cp_pr "ext/files/logback.xml", "#{@config_dir}/.."
  cp_pr "ext/files/puppetdb", "#{@bin_dir}"

  # Copy legacy wrapper for deprecated hyphenated sub-commands
  legacy_cmds=%w|puppetdb-ssl-setup puppetdb-foreground puppetdb-import puppetdb-export puppetdb-anonymize|
  legacy_cmds.each do |file|
    cp_pr "ext/files/puppetdb-legacy", "#{@bin_dir}/#{file}"
  end

  # Copy internal sub-commands to libexec location
  internal_cmds=legacy_cmds
  internal_cmds.each do |file|
    cp_pr "ext/files/#{file}", @libexec_dir
  end

  # figure out which init script to install based on facter
  if @osfamily == "redhat"
    @operatingsystem = Facter.value(:operatingsystem).downcase
    @operatingsystemrelease = Facter.value(:operatingsystemmajrelease)
    puts "operatingsystem is #{@operatingsystem}"
    puts "operatingsystemrelease is #{@operatingsystemrelease}"
    if (@operatingsystem == "fedora" && @operatingsystemrelease.to_i >= 17) || (@operatingsystem =~ /redhat|centos/ && @operatingsystemrelease.to_f >= 7 )
      #systemd!
      mkdir_p "/opt/puppet/etc/sysconfig"
      mkdir_p "/opt/puppet/lib/systemd/system"
      cp_p "ext/files/puppetdb.default.systemd", "/opt/puppet/etc/sysconfig/#{@name}"
      cp_p "ext/files/puppetdb.env", "/#{@libexec_dir}/#{@name}.env"
      cp_p "ext/files/systemd/#{@name}.service", "/opt/puppet/lib/systemd/system"
      chmod 0644, "/opt/puppet/lib/systemd/system/#{@name}.service"
    else
      mkdir_p "/opt/puppet/etc/sysconfig"
      mkdir_p "/opt/puppet/etc/init.d"
      cp_p "ext/files/puppetdb.default", "/opt/puppet/etc/sysconfig/#{@name}"
      cp_p "ext/files/puppetdb.env", "#{@libexec_dir}/#{@name}.env"
      cp_p "ext/files/puppetdb.redhat.init", "/opt/puppet/etc/init.d/#{@name}"
      chmod 0755, "/opt/puppet/etc/init.d/#{@name}"
    end
  elsif @osfamily == "debian"
    mkdir_p "/opt/puppet/etc/default"
    cp_p "ext/files/puppetdb.default", "/opt/puppet/etc/default/#{@name}"
    cp_p "ext/files/puppetdb.env", "/opt/puppet/#{@libexec_dir}/#{@name}.env"
    cp_pr "ext/files/#{@name}.debian.init", "/opt/puppet/etc/init.d/#{@name}"
    chmod 0755, "/opt/puppet/etc/init.d/#{@name}"
  end
  chmod 0750, @config_dir
  chmod 0640, "#{@config_dir}/../logback.xml"
  chmod 0700, "#{@bin_dir}/puppetdb-ssl-setup"
  chmod 0700, "#{@bin_dir}/puppetdb-foreground"
  chmod 0700, "#{@bin_dir}/puppetdb-import"
  chmod 0700, "#{@bin_dir}/puppetdb-export"
  chmod 0700, "#{@bin_dir}/puppetdb-anonymize"
  chmod 0700, "#{@bin_dir}/puppetdb"
end
