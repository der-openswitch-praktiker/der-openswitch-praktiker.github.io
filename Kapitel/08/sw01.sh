#!/bin/bash

# configuration script for OpenSwitch sw01 in lab #34


# "opx" command
ip link set dev e101-005-0 up
ip link set dev e101-006-0 up
opx-config-lag delete --name bond0
opx-config-lag create --name bond0
# or (if mode is not balance-rr): ip link add bond0 type bond mode 802.3ad
opx-config-lag set --name bond0 --enable
opx-config-lag add --name bond0 --unblockedports e101-005-0
opx-config-lag add --name bond0 --unblockedports e101-006-0

exit


# "ip" command
ip link del bond0
ip link add bond0 type bond mode 802.3ad

ip link set e101-005-0 master bond0
ip link set e101-006-0 master bond0

ip link set dev e101-005-0 up
ip link set dev e101-006-0 up
ip link set dev bond0 up
