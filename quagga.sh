#!/usr/bin/env bash
yum install -y quagga
cp /usr/share/doc/quagga-0.99.22.4/zebra.conf.sample /etc/quagga/zebra.conf
systemctl enable zebra.service --now