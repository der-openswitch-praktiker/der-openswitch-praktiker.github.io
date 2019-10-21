#!/bin/bash

function error() {
  echo -e "\e[0;33mERROR: The Zero Touch Provisioning script failed
  while running the command $BASH_COMMAND at line $BASH_LINENO.\e[0m" >&2
  exit 1
}

# [de] Kommandoausgaben in eine Logdatei umlenken
# [en] send all command output to log file
exec >> /var/log/ztd 2>&1
date "+%FT%T ztd script started"
trap error ERR

# set the hostname
sed -i -e "s/^127\.0\.1\.1.*/127.0.1.1  $new_host_name/" /etc/hosts
hostnamectl set-hostname ${new_host_name}

localectl set-locale LANG=en_US.utf8
timedatectl set-timezone Europe/Berlin

# convenience
cat <<EOF >>/etc/bash.bashrc
alias ll='ls -l'
set -o vi
EOF


# [de] SSH-Login mit Schlüssel aber ohne Passwort
# [en] login with SSH key and without password
mkdir -p ~root/.ssh/ ~admin/.ssh/
cat <<EOF > ~root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA7hx6boBbylFbmj3nI5tB0i1m7fDHAU+bidrq/h870rB9rOsm6KdbS89KzJfS88SrxlkxS5lgmc5tlzE9MWslOosmzaQhQdRjPXl410naWEAdOhekFkJUCgyVPTDfllbwq4njEEd+ejTR++dciQTmAoXgXZrHu4Sqxv45nmZY5ikF+o2VUkcEeQPPbMVJud1YeITWjLf11AROta2LwDg8rrf6Z3YynnOuvqHP9QPXKIJudyvpaMHR2aMyGyw+8yA/Igx1dSNyGqfSSkUEFc1wvbGgmqOVdnKx7z5SMn1vvicYGMwkFZuZnUOVtzYvQE0gC8qMJYrPP6O4oH+tlA2A2Q== rsa-key-opx
ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEA7hx6boBbylFbmj3nI5tB0i1m7fDHAU+bidrq/h870rB9rOsm6KdbS89KzJfS88SrxlkxS5lgmc5tlzE9MWslOosmzaQhQdRjPXl410naWEAdOhekFkJUCgyVPTDfllbwq4njEEd+ejTR++dciQTmAoXgXZrHu4Sqxv45nmZY5ikF+o2VUkcEeQPPbMVJud1YeITWjLf11AROta2LwDg8rrf6Z3YynnOuvqHP9QPXKIJudyvpaMHR2aMyGyw+8yA/Igx1dSNyGqfSSkUEFc1wvbGgmqOVdnKx7z5SMn1vvicYGMwkFZuZnUOVtzYvQE0gC8qMJYrPP6O4oH+tlA2A2Q== root@labsrv
EOF
cat ~root/.ssh/authorized_keys > ~admin/.ssh/authorized_keys 


# [de] Der "admin"-Benutzer darf ohne Kennwort root werden
# [en] user "admin" may become root without entering a password
echo "admin   ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# mark this script as success by deleting the flag file. OPX not download
# or run the script on system boot. Create this file manually to trigger
# ZTD script execution after the next reboot
rm -f /etc/opx/ztd/ztd


# trigger the automation software for configuration (like Ansible)
curl -k -f -i -H 'Content-Type:application/json' -X POST \
  --data '{"host_config_key": "cfbaae23-81c0-47f8-9a40-44493b82f06a"}' \
  https://<TOWER_SERVER_NAME>/api/v2/job_templates/1/callback/


# end of script
date "+%FT%T ztd script ended"
exit 0
