#!/bin/bash

################################
# Create SMB user.
# Globals:
#   - PASSWORD
# Arguments:
#   None
# Returns:
#   None
################################
function samba_user_create
{
    info "Create SMB user"
    smbpasswd -L -a -n timemachine

    info "Enable SMB user"
    smbpasswd -L -e -n timemachine

    local password=$(cat /var/run/secrets/password)
    readonly password

    info "Set SMB user pass"
    printf "%s\n%s\n" "${password}" "${password}" | smbpasswd -L -s timemachine
}
