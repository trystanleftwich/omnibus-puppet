name "msgpack-gem"
default_version "0.5.9"

dependency "ruby"
dependency "rubygems"

build do
  gem "install msgpack -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
end
