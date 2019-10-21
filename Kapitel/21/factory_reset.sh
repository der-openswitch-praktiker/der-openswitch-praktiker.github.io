#!/bin/bash

# Läuft dieses Skript als root-User?
if [ "$USER" != "root" ] ; then
  echo "Bitte Skript als root starten"
  echo "sudo $0"
  exit 1
fi

# alle Werte aus der Redis-Datenbank löschen
redis-cli flushall
redis-cli flushdb

# Logging-Level zurücksetzen (Datei nicht löschen sonst scheitert "opx-show-log")
echo '' > /etc/opx/evlog.cfg

# Switchports auf Autonegotiation zurücksetzen
opx-config-interface --autoneg on


# Benutzeraccounts zurücksetzen
U=$(getent passwd |awk -F : '$3 >= 1000 && $3 < 65534 {print $1}')
for user in $U ; do
  if [ "${user}" != "admin" ]; then
    userdel -r ${user}
  fi
done

for user in root admin ; do
  homedir=$(eval echo ~$user)
  rm -rf $homedir/
  mkdir --mode=700 $homedir
  cp -r /etc/skel/. $homedir/
  chown -R $user.$user $homedir
  echo -e "admin"'!'"\nadmin"'!' | (passwd $user)
done

rm -rf /var/log/*
rm -f /etc/frr/*
cat <<EOF > /etc/network/interfaces
source-directory /etc/network/interfaces.d
EOF
rm -rf /etc/network/interfaces.d/
rm -f /etc/ssh/*_key
rm -f /etc/sudoers.d/*
dpkg-reconfigure openssh-server

# Hostname zurücksetzen
hostnamectl set-hostname OPX
sed -i -e '/127.0.1.1/d' /etc/hosts
