## 12/29/2014

Latest version of puppet, facter and hiera are packaged.  Updated to work with the latest vagrant, ChefDK packaged berkshelf 3.x, omnibus 4.x, vagrant-berkshelf, and vagrant-omnibus.  The following were modified:

Berksfile:

  - Add yum-epel

config/projects/puppet:

  - Syntax changes: replaces => replace and install_path => install_dir
  - Update build version to 3.7.3
  - On redhat based systems output RPMs with the release-distribution convention.

config/software/facter-gem:

  - Syntax changes: version => default_version
  - Facter updated to 2.0.2

config/software/puppet-gem:
  - Syntax changes: version => default_version
  - Puppet updated to 3.7.3
  - Hiera updated to 1.3.4

Gemfile:

  - Make sure that omnibus-software is included

Vagrantfile:

  - Add CentOS 7 and Ubuntu 14.04.
  - Bump CentOS 5 and 6 to the latest minor versions.
  - Test for version 1.3.1 before setting deprecated/removed ssh methods.
  - Because CentOS 7 base does not contain the ```fakeroot``` package, include yum-epel in the run list to satisfy the dependency.
  - Moved server information out to the ```server.json``` file to handle the additional repository configs without cluttering up the Vagrantfile.
  - Moved the provisioning blocks up to the vm defines to ensure order and handle the per vm run lists
  - Add a shell script to check if the distribution has apt-get and then updates the indexes if it does.  The boxes from opscode bento have out of date indexes and break when installing some packages.
  - Removed inline shell code blocks for the build in favor of scripts as the ``su`` as the vagrant user was not respecting the chruby environment even when called with the ```-l``` option.  Using the script with ```privileged``` set to false runs as the vagrant user and loads the appropriate environment.
