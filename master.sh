#!/bin/bash

# configurando entorno de ejecucion
export DEBIAN_FRONTEND=noninteractive

# configurando limites de so
echo "fs.file-max=500000" >> /etc/sysctl.conf

cat << 'EOF' > /etc/security/limits.conf
# /etc/security/limits.conf
#
*               soft    nofile          500000
*               hard    nofile          500000
EOF

# instalando paquetes basicos
apt-get install -y gcc wget

# espacio de trabajo
cd /opt

# descargando jmeter
curl -sL https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.3.zip

# descomprimir descarga
unzip apache-jmeter-5.6.3.zip

# descargando plugins
cd /opt/apache-jmeter-5.6.3/lib/
wget https://repo1.maven.org/maven2/net/sf/json-lib/json-lib/2.4/json-lib-2.4-jdk15.jar
wget https://repo1.maven.org/maven2/kg/apc/cmdrunner/2.3/cmdrunner-2.3.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-cmn-jmeter/0.7/jmeter-plugins-cmn-jmeter-0.7.jar

cd /opt/apache-jmeter-5.6.3/lib/ext/
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-casutg/2.10/jmeter-plugins-casutg-2.10.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-dummy/0.4/jmeter-plugins-dummy-0.4.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-ffw/2.0/jmeter-plugins-ffw-2.0.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-fifo/0.2/jmeter-plugins-fifo-0.2.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-functions/2.2/jmeter-plugins-functions-2.2.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-graphs-basic/2.0/jmeter-plugins-graphs-basic-2.0.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/1.10/jmeter-plugins-manager-1.10.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-perfmon/2.1/jmeter-plugins-perfmon-2.1.jar
wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-tst/2.6/jmeter-plugins-tst-2.6.jar
