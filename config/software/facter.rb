name "facter"
default_version "2.0.2"

dependency "ruby"
dependency "rubygems"

build do
  gem "install facter -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
end
