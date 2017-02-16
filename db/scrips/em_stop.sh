#!/bin/bash
#
# Place this file in:
# <path>/scripts
#
# Set the file privileges to 744:
#   chmod 744 <path>/scripts/em_stop.sh
#

ORAENV_ASK=NO
. oraenv
ORAENV_ASK=YES

# Stop DBConsole
$ORACLE_HOME/bin/emctl stop dbconsole << EOF

