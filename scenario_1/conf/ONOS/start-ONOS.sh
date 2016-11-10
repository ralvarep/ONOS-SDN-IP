#!/bin/bash

# Load bashrc
PS1='$ ' . ~/.bashrc

cd $KARAF_ROOT;
pkill -f java
sleep 3
./bin/start

echo "Waiting for ONOS startup..."
sleep 60
bin/client "cfg set org.onosproject.provider.host.impl.HostLocationProvider ipv6NeighborDiscovery true"
