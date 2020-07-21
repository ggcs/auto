#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

export PATH

clear

echo

echo "#############################################################"

echo "# One click Install cloudflareddns script            #"

echo "#https://github.com/ggcs/auto#"

echo "#############################################################"

echo

stty erase '^H' && read -p "请输入 后端Key > " license_key
stty erase '^H' && read -p "请输入 节点ID > " nodeId
stty erase '^H' && read -p "请输入 面板地址 > " panelUrl
stty erase '^H' && read -p "请输入 muKey > " panelKey
stty erase '^H' && read -p "请输入 路径 > " path
stty erase '^H' && read -p "请输入 端口 > " port

clear

rm -rf v2ray-poseidon
apt install -y git
git clone https://github.com/ColetteContreras/v2ray-poseidon.git

sed -i -e "s/\"\"/\"$license_key\"/g" /root/v2ray-poseidon/docker/sspanel/ws/config.json
sed -i -e "s/1,/$nodeId,/g" /root/v2ray-poseidon/docker/sspanel/ws/config.json
sed -i -e "s/http or https:\/\/your.domain/http:\/\/$panelUrl/g" /root/v2ray-poseidon/docker/sspanel/ws/config.json
sed -i -e "s/your_panel_key/$panelKey/g" /root/v2ray-poseidon/docker/sspanel/ws/config.json
sed -i -e "s/\"\/\"/\"\/$path\"/g" /root/v2ray-poseidon/docker/sspanel/ws/config.json
sed -i -e "s/debug/off/g" /root/v2ray-poseidon/docker/sspanel/ws/config.json
sed -i -e "s/80/$port/g" /root/v2ray-poseidon/docker/sspanel/ws/docker-compose.yml

apt install -y curl
curl -fsSL https://get.docker.com | bash
curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose
rm -f `which dc`
ln -s /usr/local/bin/docker-compose /usr/bin/dc

systemctl start docker
service docker start
systemctl enable docker.service

cd /root/v2ray-poseidon/docker/sspanel/ws/
docker-compose up -d
cd 
echo OK
