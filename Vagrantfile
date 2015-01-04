# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"
require "json"

VAGRANTFILE_API_VERSION=2

if Vagrant::VERSION < "1.2.1"
  raise "The Omnibus Build Lab is only compatible with Vagrant 1.2.1+"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  host_project_path = File.expand_path("..", __FILE__)
  guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"
  project_name = ENV['OMNIBUS_PROJECT'] || "puppet"
  servers = JSON.load(File.read("./servers.json"))

  config.vm.hostname = "#{project_name}-omnibus-build-lab"

  config.vm.provider :virtualbox do |vb|
    # Give enough horsepower to build without taking all day.
    vb.customize [
      "modifyvm", :id,
      "--memory", "1536",
      "--cpus", "2"
    ]
  end

  if Vagrant::VERSION < "1.3.0"
    config.ssh.max_tries = 40
    config.ssh.timeout   = 120
  end
  config.ssh.forward_agent = true

  config.vm.synced_folder host_project_path, guest_project_path

  servers.each do |name, attrs|
    config.vm.define name do |c|
      c.berkshelf.berksfile_path = attrs['berksfile_path']
      c.vm.box = attrs['box']
      c.vm.box_url = attrs['box_url']

      # Make sure that we have updated the repo lists in case of apt-get
      c.vm.provision :shell do |s|
        s.path = "./build-scripts/apt-get-update.sh"
      end

      # prepare VM to be an Omnibus builder
      c.vm.provision :chef_solo do |chef|
        chef.json = {
          "omnibus" => {
            "build_user" => "vagrant",
            "build_dir" => guest_project_path,
            "install_dir" => "/opt/puppet",
            "ruby_version" => "2.0.0"
          }
        }

        attrs['recipes'].each do |recipe|
          chef.add_recipe recipe
        end
      end

      c.vm.provision :shell do |s|
        s.path = "./build-scripts/build.sh"
        s.args = [guest_project_path, project_name]
        s.privileged = false
      end
    end
  end

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./Berksfile"
end
