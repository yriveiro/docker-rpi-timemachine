#!/bin/bash

################################
# Info alert.
# Globals:
#   None
# Arguments:
#   $1 - message
# Returns:
#   None
################################
function info
{
    printf "\e[36m[INFO]\e[0m: ${1}\n" 2>&1
}

export -f info
