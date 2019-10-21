#!/bin/bash

# purpose: quick configure a blank OPX switch to fit my needs

SWITCH_ID=2
HOSTNAME=$(printf "sw%02d" ${SWITCH_ID})

# hostname
hostnamectl set-hostname $HOSTNAME
echo "127.0.1.1  $HOSTNAME" >> /etc/hosts

# management address
cat <<EOF > /etc/network/interfaces.d/eth0
auto eth0
iface eth0 inet static
        address 10.5.1.${SWITCH_ID}
        netmask 255.255.255.0
        gateway 10.5.1.250
        dns-nameservers 10.5.1.253
EOF

# language settings
localectl set-locale LANG=en_US.utf8
cat <<EOF >> /etc/bash.bashrc
export LANGUAGE=en_US.utf8
export LC_ALL=C
set -o vi
alias ll='ls -l'
EOF

# time zone
timedatectl set-timezone Europe/Berlin

# SSH login
mkdir ~/.ssh/
cat << EOF > ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA7hx6boBbylFbmj3nI5tB0i1m7fDHAU+bidrq/h870rB9rOsm6KdbS89KzJfS88SrxlkxS5lgmc5tlzE9MWslOosmzaQhQdRjPXl410naWEAdOhekFkJUCgyVPTDfllbwq4njEEd+ejTR++dciQTmAoXgXZrHu4Sqxv45nmZY5ikF+o2VUkcEeQPPbMVJud1YeITWjLf11AROta2LwDg8rrf6Z3YynnOuvqHP9QPXKIJudyvpaMHR2aMyGyw+8yA/Igx1dSNyGqfSSkUEFc1wvbGgmqOVdnKx7z5SMn1vvicYGMwkFZuZnUOVtzYvQE0gC8qMJYrPP6O4oH+tlA2A2Q== rsa-key-opx
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA7hx6boBbylFbmj3nI5tB0i1m7fDHAU+bidrq/h870rB9rOsm6KdbS89KzJfS88SrxlkxS5lgmc5tlzE9MWslOosmzaQhQdRjPXl410naWEAdOhekFkJUCgyVPTDfllbwq4njEEd+ejTR++dciQTmAoXgXZrHu4Sqxv45nmZY5ikF+o2VUkcEeQPPbMVJud1YeITWjLf11AROta2LwDg8rrf6Z3YynnOuvqHP9QPXKIJudyvpaMHR2aMyGyw+8yA/Igx1dSNyGqfSSkUEFc1wvbGgmqOVdnKx7z5SMn1vvicYGMwkFZuZnUOVtzYvQE0gC8qMJYrPP6O4oH+tlA2A2Q== root@labsrv
EOF
mkdir ~admin/.ssh/
cp ~/.ssh/authorized_keys ~admin/.ssh/

# disable beep in VMware/VirtualBox
echo "set bell-style none" >> /etc/inputrc

# allow admin to become root via sudo
echo "admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/admin
