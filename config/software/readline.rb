name "readline"
default_version "6.3"

source :url => "ftp://ftp.cwru.edu/pub/bash/readline-#{version}.tar.gz",
       :md5 => "33c8fb279e981274f485fd91da77e94a"

relative_path "readline-#{version}"

build do
  env = env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make " , :env => env
  command "make install" , :env => env
end
