name "puppet-gem"
default_version "3.7.3"

dependency "ruby"
dependency "rubygems"
dependency "facter-gem"

build do
  gem "install hiera -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v '1.3.4'"
  gem "install puppet -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"

  %w{share/man ssl/man man}.each do |dir|
    command "rm -rf #{install_dir}/embedded/#{dir}"
  end
end
