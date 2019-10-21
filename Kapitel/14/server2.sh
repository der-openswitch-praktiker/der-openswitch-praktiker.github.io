!
frr version 7.1
frr defaults traditional
hostname server2
log syslog informational
no ip forwarding
no ipv6 forwarding
service integrated-vtysh-config
!
interface eth1
 bandwidth 1000
 description sw11:e101-006-0
 ip address 32.32.32.32/32
 ip ospf area 0
 ip ospf dead-interval 4
 ip ospf hello-interval 1
 ip ospf network point-to-point
 ipv6 ospf6 dead-interval 4
 ipv6 ospf6 hello-interval 1
 ipv6 ospf6 network point-to-point
!
interface eth2
 bandwidth 1000
 description sw12:e101-006-0
 ip address 32.32.32.32/32
 ip ospf area 0
 ip ospf dead-interval 4
 ip ospf hello-interval 1
 ip ospf network point-to-point
 ipv6 ospf6 dead-interval 4
 ipv6 ospf6 hello-interval 1
 ipv6 ospf6 network point-to-point
!
interface lo
 ip address 32.32.32.1/32
 ip address 32.32.32.2/32
 ip address 32.32.32.3/32
 ip address 32.32.32.32/32
 ip address 32.32.32.4/32
 ip ospf area 0
 ipv6 address fd00:11:32::1/128
!
router ospf
 ospf router-id 32.32.32.32
 auto-cost reference-bandwidth 40000
 passive-interface eth0
!
router ospf6
 ospf6 router-id 32.32.32.32
 auto-cost reference-bandwidth 40000
 interface eth1 area 0.0.0.1
 interface eth2 area 0.0.0.1
 interface lo area 0.0.0.1
!
line vty
!
bfd
!
end
