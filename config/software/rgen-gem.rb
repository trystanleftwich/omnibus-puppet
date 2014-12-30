name "rgen-gem"
default_version "0.7.0"

dependency "ruby"
dependency "rubygems"

build do
  gem "install rgen -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
end
