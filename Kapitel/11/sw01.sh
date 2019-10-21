#!/bin/bash

# configuration script for OpenSwitch sw01 in lab #24


ip link set e101-003-0 up # connects to sw13
ip link set e101-007-0 up # connects to labsrv

brctl addbr br24
brctl addif br24 e101-003-0
brctl addif br24 e101-007-0
ip link set br24 up

# add tagged dummy interface (required for bridge to accept traffic)
ip link add link e101-001-0 name e101-001-0.100 type vlan id 100
ip link set e101-001-0 up
brctl addif br24 e101-001-0.100
