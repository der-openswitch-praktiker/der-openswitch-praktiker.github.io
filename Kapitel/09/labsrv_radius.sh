#!/bin/bash

# purpose: install FreeRADIUS on lab server "labsrv"

# version
#  FreeRadius 3.0.17
#  Debian Linux 10.0


# install
apt install freeradius
systemctl enable freeradius

# configuration
cat <<EOF >> /etc/freeradius/3.0/clients.conf
client openswitch_lab {
   ipaddr = 0.0.0.0/0
   secret = OpenSwitch22
}
EOF
cat <<EOF >> /etc/freeradius/3.0/users
scooper    Cleartext-Password := 'OpenSwitch22'
EOF

# start
systemctl start freeradius

# logging
tail -n0 -f /var/log/freeradius/radius.log
