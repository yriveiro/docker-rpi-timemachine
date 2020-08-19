#!/bin/bash

################################
# Create Avahi SMB service.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
################################
function avahi_smbd_cnf
{
    info "Write Avahi SMB service"

    cat << EOF > /etc/avahi/services/smbd.service
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">

<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_smb._tcp</type>
    <port>${SMB_PORT}</port>
  </service>
  <service>
    <type>_device-info._tcp</type>
    <port>9</port>
  <txt-record>model=${MIMIC_MODEL}</txt-record>
  </service>
  <service>
    <type>_adisk._tcp</type>
    <port>9</port>
    <txt-record>sys=adVF=0x100</txt-record>
    <txt-record>dk0=adVN=${SHARE_NAME},adVF=0x82</txt-record>
  </service>
</service-group>
EOF
}
