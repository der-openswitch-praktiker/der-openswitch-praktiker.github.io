#!/bin/bash

# purpose: install TACACS+ on lab server "labsrv"


# TACACS+ daemon
apt install tacacs+
cat <<EOF > /etc/tacacs+/tac_plus.conf
accounting file = /var/log/tac_plus.acct
key = OpenSwitch22
user = rhendric {
  global = cleartext OpenSwitch22
  service = ppp
  protocol = ip {
  }
}
EOF

# start TACACS+ daemon
/usr/sbin/tac_plus -C /etc/tacacs+/tac_plus.conf -t -d 512
