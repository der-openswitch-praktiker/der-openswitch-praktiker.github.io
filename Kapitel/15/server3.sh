#!/bin/bash

# purpose: bridge both uplinks together

apt install bridge-utils

brctl addbr br0
brctl addif br0 eth1
brctl addif br0 eth2
brctl stp br0 off

ip link set eth1 up
ip link set eth2 up
ip link set br0 up

ip addr add 10.1.36.33/24 dev br0
