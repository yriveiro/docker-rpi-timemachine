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
# Set timemachine user password.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
################################
function set_passwrd
{
    info "Set password"

    echo "timemachine:$(cat /var/run/secrets/password)" | chpasswd
}
