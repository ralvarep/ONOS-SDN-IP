#!/bin/bash

echo "Checking Open vSwitch status..."
while true; do
      if [ -S /var/run/openvswitch/db.sock ]; then
         break
      fi
      sleep 2
done

echo "Configuring Open vSwitch..."
ovs-vsctl add-br s13
ovs-vsctl add-port s13 eth1
ovs-vsctl add-port s13 eth2
ovs-vsctl add-port s13 eth3
ovs-vsctl set bridge s13 other-config:hwaddr=00:00:00:00:00:13
ovs-vsctl set bridge s13 protocols=OpenFlow13
ovs-vsctl set-controller s13 tcp:10.100.10.1:6633
ovs-vsctl set-fail-mode s13 secure
