#!/bin/bash
## Virtuelle Maschinen erstellen und verkabeln

# run all commands as vbox user
if [ "$USER" != "vbox" ] ; then
  exit 1
fi

# OVF-Datei erstellen

# Spine-Switches erstellen
./sw_import-vbox.sh 01
./sw_import-vbox.sh 02

# Leaf-Switches erstellen
./sw_import-vbox.sh 11
./sw_import-vbox.sh 12
./sw_import-vbox.sh 13
./sw_import-vbox.sh 14

# Switches verkabeln
./sw_cabling-vbox.sh

# MAC-Adressen zuweisen
./sw_macaddr-vbox.sh

# Switches starten
for SWITCH_ID in {01,02,11,12,13,14} ; do
  VBoxHeadless --startvm sw${SWITCH_ID} &
  sleep 1
done
