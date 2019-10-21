#!/bin/bash

# purpose: configure sw11 for spanning-tree scenario "looped triangle"


# start MSTP daemon in the background
/sbin/mstpd

# create a new bridge
brctl addbr br20
brctl stp br20 on
mstpctl addbridge br20
mstpctl setforcevers br20 rstp

# enable interfaces and merge to bridge
ip link set e101-001-0 up
brctl addif br20 e101-001-0
ip link set e101-002-0 up
brctl addif br20 e101-002-0
ip link set br20 up

# add tagged dummy interface (required for bridge to accept traffic)
ip link add link e101-030-0 name e101-030-0.30 type vlan id 30
ip link set e101-030-0 up
brctl addif br20 e101-030-0.30

# protect access ports from incoming BPDUs
mstpctl setbpduguard br20 e101-005-0 yes
mstpctl setbpduguard br20 e101-006-0 yes

# protect access ports from becoming root ports
mstpctl setportrestrrole br20 e101-005-0 yes
mstpctl setportrestrrole br20 e101-006-0 yes

exit 0
