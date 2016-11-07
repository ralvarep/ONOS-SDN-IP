#!/bin/bash

echo "Checking Open vSwitch status..."
while true; do
      if [ -S /var/run/openvswitch/db.sock ]; then
         break
      fi
      sleep 2
done

echo "Configuring Open vSwitch..."
ovs-vsctl add-br s11
ovs-vsctl add-port s11 eth1
ovs-vsctl add-port s11 eth2
ovs-vsctl add-port s11 eth3
ovs-vsctl set bridge s11 other-config:hwaddr=00:00:00:00:00:11
ovs-vsctl set bridge s11 protocols=OpenFlow13
ovs-vsctl set-controller s11 tcp:10.100.10.1:6633
ovs-vsctl set-fail-mode s11 secure
