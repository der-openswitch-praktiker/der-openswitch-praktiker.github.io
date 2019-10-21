!
frr version 7.1
frr defaults traditional
hostname server3
log syslog informational
no ip forwarding
no ipv6 forwarding
service integrated-vtysh-config
!
interface eth1
 bandwidth 1000
 description sw13:e101-005-0
 ip address 33.33.33.33/32
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
 description sw14:e101-005-0
 ip address 33.33.33.33/32
 ip ospf area 0
 ip ospf dead-interval 4
 ip ospf hello-interval 1
 ip ospf network point-to-point
 ipv6 ospf6 dead-interval 4
 ipv6 ospf6 hello-interval 1
 ipv6 ospf6 network point-to-point
!
interface lo
 ip address 33.33.33.1/32
 ip address 33.33.33.2/32
 ip address 33.33.33.3/32
 ip address 33.33.33.33/32
 ip address 33.33.33.4/32
 ip ospf area 0
 ipv6 address fd00:22:33::1/128
!
router ospf
 ospf router-id 33.33.33.33
 auto-cost reference-bandwidth 40000
 passive-interface eth0
!
router ospf6
 ospf6 router-id 33.33.33.33
 auto-cost reference-bandwidth 40000
 interface eth1 area 0.0.0.2
 interface eth2 area 0.0.0.2
 interface lo area 0.0.0.2
!
line vty
!
bfd
!
end
