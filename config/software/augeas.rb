name "augeas"
default_version "1.3.0"

dependency "libxml2"
dependency "libxslt"
dependency "readline"

source :url => "http://download.augeas.net/augeas-#{version}.tar.gz",
       :md5 => "c8890b11a04795ecfe5526eeae946b2d"

relative_path "augeas-#{version}"

build do
  env = env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded --without-selinux" , :env => env
  command "make " , :env => env
  command "make install" , :env => env
end
