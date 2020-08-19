#!/bin/bash

set -euo pipefail

if [ "${DEBUG}" = "1" ];then
    set -x
fi

. /usr/local/lib/timemachine/liblog.sh
. /usr/local/lib/timemachine/libutil.sh
. /usr/local/lib/timemachine/libsmb.sh
. /usr/local/lib/timemachine/templates/smb_cnf.sh
. /usr/local/lib/timemachine/templates/avahi_smb_service.sh

set_passwrd
smb_cnf
samba_user_create
avahi_smbd_cnf
cleanup
