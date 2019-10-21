#!/bin/bash

# purpose: set up this switch as static VXLAN tunnel endpoint

mstpd || ( echo Bitte mstpd installieren && exit 0 )

# dynamic tunnels to other VTEPs using muticast in the underlay network
ip link add vxlan0 type vxlan id 36 dstport 4789 local 11.11.11.11 group 239.1.1.36 ttl 5 dev e101-001-0 dev e101-002-0

# assign access interface to VLAN 36
opx-config-vlan create --id 36
opx-config-vlan set --id 36 --ports e101-006-0
brctl stp br36 on
mstpctl setforcevers br36 rstp

# bridge VTEP to VLAN 36 (that is: br36)
ip link set vxlan0 master br36

# start up the interfaces
ip link set e101-006-0 up
ip link set vxlan0 up
ip link set br36 up
