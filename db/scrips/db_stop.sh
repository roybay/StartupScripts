#!/bin/bash
#
# Place this file in:
# <path>/scripts
#
# Set the file privileges to 744:
#   chmod 744 <path>/scripts/db_stop.sh
#

ORAENV_ASK=NO
. oraenv
ORAENV_ASK=YES

# Stop Database
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
SHUTDOWN IMMEDIATE;
EXIT;
EOF

