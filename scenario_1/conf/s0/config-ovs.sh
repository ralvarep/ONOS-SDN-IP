#!/bin/bash

echo "Starting Open vSwitch..."
service openvswitch-switch start

echo "Checking Open vSwitch status..."
while true; do
      if [ -S /var/run/openvswitch/db.sock ]; then
         break
      fi
      sleep 2
done

echo "Configuring Open vSwitch..."
ovs-vsctl add-br s0
ovs-vsctl add-port s0 eth1
ovs-vsctl add-port s0 eth2
ovs-vsctl add-port s0 eth3
ovs-vsctl add-port s0 eth4
ovs-vsctl set bridge s0 other-config:hwaddr=00:00:00:00:01:00
ovs-vsctl set bridge s0 protocols=OpenFlow13
ovs-vsctl set-controller s0 tcp:10.100.10.1:6633
ovs-vsctl set-fail-mode s0 secure
