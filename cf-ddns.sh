#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

export PATH

clear

echo

echo "#############################################################"

echo "#############################################################"

echo "请输入 邮箱 > " ;read ddnsemail

echo "请输入 Key > " ;read auth_key

echo "请输入 顶级域名> " ;read zone_name

echo "请输入 二级域名 > " ;read record_name

wget --no-check-certificate https://raw.githubusercontent.com/ggcs/cloudflare-api-v4-ddns/master/cf-v4-ddns.sh

mv cf-v4-ddns.sh ddns.sh

sed -i 's/user@example.com/${ddnsemail}/g' ddns.sh

sed -i 's/c9320b638f5e225/${auth_key}/g' ddns.sh

sed -i 's/example.com/${zone_name}/g' ddns.sh

sed -i 's/www.example.com/${record_name}/g' ddns.sh

chmod +x ddns.sh
./ddns.sh

		if [ ! -d "//var/spool/cron/crontabs/" ];then

			echo "*/2 * * * * /root/ddns.sh >/dev/null 2>&1" >> /var/spool/cron/root
      service cron restart
		else

			echo "*/2 * * * * /root/ddns.sh >/dev/null 2>&1" >> /var/spool/cron/crontabs/root
      service crontab restart
		fi

		
    
    crontab -e
    echo 'Over'
