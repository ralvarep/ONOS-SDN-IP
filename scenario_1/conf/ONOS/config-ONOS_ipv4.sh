#!/bin/bash

# Load bashrc
PS1='$ ' . ~/.bashrc

echo 'ONOS_APPS=drivers,openflow,proxyarp,sdnip' >> ~/.bashrc
export ONOS_APPS=drivers,openflow,proxyarp,sdnip
~/onos/tools/dev/bin/onos-setup-karaf clean
cp ~/conf/network-cfg_ipv4.json $KARAF_ROOT/../config/network-cfg.json
