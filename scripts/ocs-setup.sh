#!/bin/bash

if [ ! -f "/etc/nginx/sites-enabled/ocs.conf" ]; then
    apt install -y iproute2
    wget https://nginx.org/packages/ubuntu/pool/nginx/n/nginx/nginx_1.20.2-1~jammy_amd64.deb
    dpkg -i nginx_1.20.2-1~jammy_amd64.deb
    cp /root/nginx.conf /etc/nginx/nginx.conf
    rm /etc/nginx/conf.d/default.conf -f
    mkdir /etc/nginx/{auth,sites-enabled}
    ln -s /etc/nginx/sites-available/ocs.conf /etc/nginx/sites-enabled/ocs.conf
    echo "ocsapi:$apr1$BcAk5f/A$0O5c/DSy92/o.vpwwshWQ." > /etc/nginx/auth/ocsapi.htpasswd

fi

apachectl start
nginx