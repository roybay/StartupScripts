#!/bin/bash
#
# Place this file in:
# <path>/scripts
#
# Set the file privileges to 744:
#   chmod 744 <path>/scripts/db_start.sh
#

ORAENV_ASK=NO
. oraenv
ORAENV_ASK=YES

# Start Listener
$ORACLE_HOME/bin/lsnrctl start

# Start Database
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
STARTUP;
EXIT;
EOF

