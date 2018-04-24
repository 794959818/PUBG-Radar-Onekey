#!/bin/bash
echo "欢迎使用网页雷达一键脚本"
echo "即将搭建的是随的4.23版本"
echo "请输入交流群号"
read -p "交流群： " qun
echo "请输入你的内网ip" 
read -p "内网ip： " ip

curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
source ~/.bash_profile
nvm install v9.8.0
nvm alias default v9.8.0
yum -y install gcc-c++
yum -y install flex
yum -y install bison
wget http://www.tcpdump.org/release/libpcap-1.8.1.tar.gz
tar -zxvf libpcap-1.8.1.tar.gz
cd libpcap-1.8.1
./configure
make
make install


npm i
npm i -g pino
npm install -g forever

wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
forever start index.js sniff eth0 $ip | pino

echo "搭建完成"
