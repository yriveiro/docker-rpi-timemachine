#!/bin/bash

################################
# Create SMB config.
# Globals:
#   - ${WORKGROUP}
#   - ${SMB_PORT}
#   - ${HIDE_SHARES}
#   - ${MIMIC_MODEL}
#   - ${SHARE_NAME}
#   - ${VOLUME_SIZE_LIMIT}
#   - ${TM_USERNAME}
# Arguments:
#   None
# Returns:
#   - SMB cnf file with all variables interpolated.
################################
function smb_cnf
{
    info "Write SMB config"

    cat << EOF > /etc/samba/smb.conf
[global]
   server role = standalone server
   workgroup = ${WORKGROUP}
   smb ports = ${SMB_PORT}
   unix password sync = yes
   log file = /var/log/samba/log.%m
   logging = file
   max log size = 1000
   security = user
   load printers = no
   access based share enum = ${HIDE_SHARES}
   hide unreadable = ${HIDE_SHARES}
   fruit:model = ${MIMIC_MODEL}
[${SHARE_NAME}]
   fruit:aapl = yes
   fruit:time machine = yes
   fruit:time machine max size = ${VOLUME_SIZE_LIMIT}
   path = /opt/${TM_USERNAME}
   valid users = ${TM_USERNAME}
   browseable = yes
   writable = yes
   vfs objects = catia fruit streams_xattr"
EOF
}
