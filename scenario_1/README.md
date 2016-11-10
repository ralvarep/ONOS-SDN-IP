# ONOS / CORD Project → SDN-IP → Scenario 1

This repository provides a virtual scenario to explore the SDN-IP service of the ONOS / CORD Project.

Demo scenario has been created using [Virtual Networks over linuX (VNX)](http://www.dit.upm.es/~vnx/).

Index:
- [Requirements](https://github.com/ralvarep/ONOS-SDN-IP#requirements)
- [Scenario](https://github.com/ralvarep/ONOS-SDN-IP#scenario)
- [Usage](https://github.com/ralvarep/ONOS-SDN-IP#usage)
- [Author](https://github.com/ralvarep/ONOS-SDN-IP#author)
- [References](https://github.com/ralvarep/ONOS-SDN-IP#references)


## Requirements

 - VNX installed [(VNX Installation Guide)](http://web.dit.upm.es/vnxwiki/index.php/Vnx-install)
 - Operating System: Ubuntu 14.04 / Ubuntu 16.04
 - Hard Drive: 3,5 GB avaible space (Filesystem size)
 - Memory: 4 GB RAM or more


## Scenario

![Scenario](https://raw.githubusercontent.com/ralvarep/ONOS-SDN-IP/master/scenario_1/img/scenario.png)


## Usage

**STEP 1: Clone this repository**
~~~
$ git clone https://github.com/ralvarep/ONOS-SDN-IP.git
~~~

**STEP 2: Build filesystem**

The virtual scenario has been configured using the filesystem in [copy-on-write (COW) mode](https://en.wikipedia.org/wiki/Copy-on-write). This allows you to use a single filesystem for all virtual machines, thereby optimizing the disk space occupied.

Depending on your operating system, execute:
~~~
$ filesystems/create-rootfs_ubuntu14.04
~~~
~~~
$ filesystems/create-rootfs_ubuntu16.04
~~~
This step takes about 20-30 min. It will download all the necessary packages of the demo scenario.

**STEP 3: Create virtual scenario**

Move to a specific scenario folder and execute:
~~~
$ sudo vnx -f ONOS-SDN-IP.xml -t
~~~
When the scenario is created, you can login to consoles with root:xxxx.

**STEP 4: Start virtual scenario services**

The virtual scenarios can be started with different configurations.
~~~
$ sudo vnx -f ONOS-SDN-IP.xml -x CONF_TAG

 CONF_TAG => start-ipv4  (IPv4 BGP peering session between external routers and the internal router)
          => start-ipv6  (IPv6 BGP peering session between external routers and the internal router)
~~~
When the scenario is created, you can login to consoles with root:xxxx.

**STEP 5: Check ONOS (SDN Controller)**

Enter in the ONOS console and execute the following command to check if ONOS is running:
~~~
root@ONOS:~# ~/Applications/apache-karaf-3.0.5/bin/status
Running ...
~~~
To enter in the Karaf Console, execute:
~~~
root@ONOS:~# ~/Applications/apache-karaf-3.0.5/bin/client
Logging in as onos
Welcome to Open Network Operating System (ONOS)!
     ____  _  ______  ____     
    / __ \/ |/ / __ \/ __/   
   / /_/ /    / /_/ /\ \     
   \____/_/|_/\____/___/     
                               
onos> 
~~~
In the event that ONOS is not running, you can launch it by hand executing #ok clean.

Once you are in the Karaf Console, you can check the active applications:
~~~
onos> apps -s -a
*  11 org.onosproject.hostprovider         1.7.1.SNAPSHOT Host Location Provider
*  12 org.onosproject.lldpprovider         1.7.1.SNAPSHOT LLDP Link Provider
*  13 org.onosproject.optical-model        1.7.1.SNAPSHOT Optical information model
*  14 org.onosproject.openflow-base        1.7.1.SNAPSHOT OpenFlow Provider
*  15 org.onosproject.openflow             1.7.1.SNAPSHOT OpenFlow Meta App
*  29 org.onosproject.proxyarp             1.7.1.SNAPSHOT Proxy ARP/NDP App
*  33 org.onosproject.drivers              1.7.1.SNAPSHOT Default Device Drivers
* 101 org.onosproject.sdnip                1.7.1.SNAPSHOT SDN-IP App
~~~
and the learned routes:
~~~
onos> routes
Table: ipv4
   Network            Next Hop
   10.101.0.0/24      10.100.101.2   
   10.102.0.0/24      10.100.102.2   
   10.103.0.0/24      10.100.103.2   
   Total: 3

Table: ipv6
   Network            Next Hop
   2001:db8:101::/64  2001:db8:100:101::2
   2001:db8:102::/64  2001:db8:100:102::2
   2001:db8:103::/64  2001:db8:100:103::2
   Total: 3
~~~
Also, you can monitor the state of the SDN-IP service:
~~~
onos> bgp-routes 
   Network            Next Hop        Origin LocalPref       MED BGP-ID
   10.101.0.0/24      10.100.101.2       IGP       100         0 10.0.0.100     
                      AsPath 101
   10.102.0.0/24      10.100.102.2       IGP       100         0 10.0.0.100     
                      AsPath 102
   10.103.0.0/24      10.100.103.2       IGP       100         0 10.0.0.100     
                      AsPath 103
Total BGP IPv4 routes = 3

   Network            Next Hop        Origin LocalPref       MED BGP-ID
   2001:db8:101::/64  2001:db8:100:101::2    IGP       100         0 10.0.0.100     
                      AsPath 101
   2001:db8:102::/64  2001:db8:100:102::2    IGP       100         0 10.0.0.100     
                      AsPath 102
   2001:db8:103::/64  2001:db8:100:103::2    IGP       100         0 10.0.0.100     
                      AsPath 103
Total BGP IPv6 routes = 3
~~~

~~~
onos> bgp-neighbors 
BGP neighbor is 10.0.0.100, remote AS 100, local AS 100
  Remote router ID 10.0.0.100, IP /10.100.11.2:47810, BGP version 4, Hold time 180
  Remote AFI/SAFI IPv4 Unicast YES Multicast NO, IPv6 Unicast YES Multicast NO
  Local  router ID 10.100.11.1, IP /10.100.11.1:2000, BGP version 4, Hold time 180
  Local  AFI/SAFI IPv4 Unicast YES Multicast NO, IPv6 Unicast YES Multicast NO
  4 Octet AS Capability: Advertised Received
~~~

BGP Speakers with IPv4 configuration:
~~~
onos> bgp-speakers 
speaker1: port=of:0000000000000100/4, vlan=None, peers=[10.100.101.2, 10.100.102.2, 10.100.103.2]
~~~

BGP Speakers with IPv6 configuration:
~~~
onos> bgp-speakers 
speaker1: port=of:0000000000000100/4, vlan=None, peers=[2001:db8:100:101::2, 2001:db8:100:102::2, 2001:db8:100:103::2]
~~~

In addition, ONOS GUI is avaible from your host through [http://10.250.0.2:8181/onos/ui/login.html](http://10.250.0.2:8181/onos/ui/login.html). To login karaf:karaf.

![ONOS-GUI](https://raw.githubusercontent.com/ralvarep/ONOS-SDN-IP/master/scenario_1/img/ONOS-GUI.jpg)


**STEP 6: Connectivity Test between clients**

Now you can test the connectivity between the clients. For example, entering in the client-101 console:
~~~
root@client-101:~# ping 10.102.0.2
PING 10.102.0.2 (10.102.0.2) 56(84) bytes of data.
64 bytes from 10.102.0.2: icmp_seq=1 ttl=62 time=0.927 ms
64 bytes from 10.102.0.2: icmp_seq=2 ttl=62 time=0.105 ms

root@client-101:~# ping 10.103.0.2
PING 10.103.0.2 (10.103.0.2) 56(84) bytes of data.
64 bytes from 10.103.0.2: icmp_seq=1 ttl=62 time=0.392 ms
64 bytes from 10.103.0.2: icmp_seq=2 ttl=62 time=0.249 ms
~~~

~~~
root@client-101:~# ping6 2001:db8:102::2
PING 2001:db8:102::2(2001:db8:102::2) 56 data bytes
64 bytes from 2001:db8:102::2: icmp_seq=1 ttl=62 time=4.02 ms
64 bytes from 2001:db8:102::2: icmp_seq=2 ttl=62 time=0.134 ms

root@client-101:~# ping6 2001:db8:103::2
PING 2001:db8:103::2(2001:db8:103::2) 56 data bytes
64 bytes from 2001:db8:103::2: icmp_seq=1 ttl=62 time=2.23 ms
64 bytes from 2001:db8:103::2: icmp_seq=2 ttl=62 time=0.116 ms
~~~

**OTHER OPTIONS:**

* Launch terminal of some virtual machine
~~~
$ sudo vnx -f ONOS-SDN-IP.xml --console -M VM-NAME
~~~
* Shutdown scenario
~~~
$ sudo vnx -f ONOS-SDN-IP.xml --shutdown
~~~
* Start scenario that has previously been shutdown
~~~
$ sudo vnx -f ONOS-SDN-IP.xml --start
~~~
* Destroy scenario
~~~
$ sudo vnx -f ONOS-SDN-IP.xml -P
~~~


## Author

This project has been developed by [Raúl Álvarez Pinilla](https://es.linkedin.com/in/raulalvarezpinilla).


## References

 *  [ONOS Project](http://onosproject.org/)
 *  [CORD Project](http://opencord.org/)
 *  [SDN-IP (Wiki)](https://wiki.onosproject.org/display/ONOS/SDN-IP)
 *  [SDN-IP (IPv6)](https://wiki.onosproject.org/display/ONOS/IPv6#IPv6-IPv6RoutesforSDN-IPUseCase)
 *  [Quagga](http://www.nongnu.org/quagga/)
