#!/bin/bash
#export ECHO_ON=1
[[ $ECHO_ON = "1" ]] && echo Starting ~/.bashrc
export SCRIPTS_PATH=~/scripts/
source "$SCRIPTS_PATH/src/load.sh"
[[ $ECHO_ON = "1" ]] && echo .bashrc loaded
