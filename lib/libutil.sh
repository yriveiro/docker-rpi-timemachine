#!/bin/bash

################################
# Check if we are running as user root.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   The result of the test command, true if equals false otherwise.
################################
function running_as_root
{
    test "$(id -u)" = "0"
}

################################
# Clenaup leftover PIDs.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
################################
function cleanup
{
  for PIDFILE in nmbd smbd
  do
    if [ -f /run/samba/${PIDFILE}.pid ]
    then
      info "${PIDFILE} PID exists; removing..."
      rm -v /run/samba/${PIDFILE}.pid
    fi
  done

  # cleanup dbus PID file
  if [ -f /run/dbus.pid ]
  then
    info "dbus PID exists; removing..."
    rm -v /run/dbus.pid
  fi

  # cleanup avahi PID file
  if [ -f /run/avahi-daemon/pid ]
  then
    info "avahi PID exists; removing..."
    rm -v /run/avahi-daemon/pid
  fi
}

################################
# Create timemachine user.
# Globals:
#   - TM_UID
#   - TM_GID
#   - TM_USERNAME
#   - TM_GROUPNAME
#   - PASSWORD
# Arguments:
#   None
# Returns:
#   None
################################
function create_user
{
    info "Create user"
    addgroup -g "${TM_GID}" "${TM_GROUPNAME}"
    adduser -u "${TM_UID}" -G "${TM_GROUPNAME}" -h "/opt/${TM_USERNAME}" -s /bin/false -D "${TM_USERNAME}"

    info "Set password"
    echo "${TM_USERNAME}":"${PASSWORD}" | chpasswd
}
