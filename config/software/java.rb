name "java"
default_version "7u3-b04"

whitelist_file "jre/bin/javaws"
whitelist_file "jre/bin/policytool"
whitelist_file "jre/lib"
whitelist_file "jre/plugin"

source url: "http://download.oracle.com/otn-pub/java/jdk/7u3-b04/jre-7u3-linux-x64.tar.gz",
  md5: "3d3e206cea84129f1daa8e62bf656a28",
  cookie: 'oraclelicense=accept-securebackup-cookie;gpw_e24=http://www.oracle.com/technetwork/java/javase/downloads/jre7-downloads-1880261.html',
  warning: "By including the JRE, you accept the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, which can be found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html",
  unsafe: true

relative_path "jre1.7.0_03"

build do
  sync "#{project_dir}/", "#{install_dir}/embedded/jre"
end
