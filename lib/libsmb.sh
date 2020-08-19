#!/bin/bash

################################
# Create SMB user.
# Globals:
#   - TM_USERNAME
#   - PASSWORD
# Arguments:
#   None
# Returns:
#   None
################################
function samba_user_create
{
    info "Create SMB user"
    smbpasswd -L -a -n "${TM_USERNAME}"

    info "Enable SMB user"
    smbpasswd -L -e -n "${TM_USERNAME}"

    info "Set SMB user pass"
    printf "%s\n%s\n" "${PASSWORD}" "${PASSWORD}" | smbpasswd -L -s "${TM_USERNAME}"
}
