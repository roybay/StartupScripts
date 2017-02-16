#!/bin/bash
#
# Place this file in:
# <path>/scripts
#
# Set the file privileges to 744:
#   chmod 744 <path>/scripts/em_start.sh
#

ORAENV_ASK=NO
. oraenv
ORAENV_ASK=YES

# Start DBConsole
$ORACLE_HOME/bin/emctl start dbconsole << EOF

