#!/bin/bash

# purpose: configure sw01 to connect sw23 (ER-X) and client1 (ESXi)

# bridge interfaces together
opx-config-vlan create --id 1
opx-config-vlan add --id 1 --ports e101-014-0
opx-config-vlan add --id 1 --ports e101-031-0

# enable switchports
ip link set e101-014-0 up
ip link set e101-031-0 up
ip link set br1 up

exit 0
