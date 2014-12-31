name "hiera"
default_version "1.3.4"

dependency "ruby"
dependency "rubygems"

build do
  gem "install hiera -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}"
end
