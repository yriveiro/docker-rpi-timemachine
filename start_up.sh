#!/bin/bash

set -euo pipefail

# set default values
DEBUG=${DEBUG:-0}
LOG_LEVEL="${LOG_LEVEL:-info}"
SHARE_NAME="${SHARE_NAME:-TimeMachine}"
SMB_PORT="${SMB_PORT:-445}"
TM_USERNAME="${TM_USERNAME:-timemachine}"
TM_GROUPNAME="${TM_GROUPNAME:-timemachine}"
TM_UID="${TM_UID:-1000}"
TM_GID="${TM_GID:-${TM_UID}}"
VOLUME_SIZE_LIMIT="${VOLUME_SIZE_LIMIT:-0}"
WORKGROUP="${WORKGROUP:-WORKGROUP}"
HIDE_SHARES="${HIDE_SHARES:-no}"
PASSWORD="${PASSWORD:-$(cat /run/secrets/password)}"
MIMIC_MODEL="${MIMIC_MODEL:-TimeCapsule8,119}"

if [ "${DEBUG}" = "1" ];then
    set -x
fi

. /usr/local/lib/timemachine/liblog.sh
. /usr/local/lib/timemachine/libutil.sh
. /usr/local/lib/timemachine/libsmb.sh
. /usr/local/lib/timemachine/templates/smb_cnf.sh
. /usr/local/lib/timemachine/templates/avahi_smb_service.sh

create_user
smb_cnf
samba_user_create
avahi_smbd_cnf
cleanup
