#!/bin/bash

# configuration script for OpenSwitch sw02 in lab #34

ip link set dev e101-005-0 up
ip link set dev e101-006-0 up
opx-config-lag delete --name bond0
opx-config-lag create --name bond0
opx-config-lag set --name bond0 --enable
opx-config-lag add --name bond0 --unblockedports e101-005-0
opx-config-lag add --name bond0 --unblockedports e101-006-0
