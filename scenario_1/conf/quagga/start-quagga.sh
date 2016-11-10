#!/bin/bash

pkill -f zebra
pkill -f bgpd

sleep 5

ifconfig eth2 down
ifconfig eth2 hw ether 00:00:00:00:00:01
ip address add 10.100.101.1/24 dev eth2
ip address add 10.100.102.1/24 dev eth2
ip address add 10.100.103.1/24 dev eth2
ip address add 2001:db8:100:101::1/64 dev eth2
ip address add 2001:db8:100:102::1/64 dev eth2
ip address add 2001:db8:100:103::1/64 dev eth2
ifconfig eth2 up

chmod a+w /var/run
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
zebra -d
bgpd -d
