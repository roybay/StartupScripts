#!/bin/bash
# chkconfig: 345 99 4
# description: start nodemanager
#
. /<path>/scripts/manage.properties

su - $ORACLE_OWNER -c "export JAVA_OPTIONS='$JAVAOPTIONS';. $DOMAIN_HOME/bin/setDomainEnv.sh; nohup $WL_HOME/server/bin/startNodeManager.sh > /<path>/scripts/nodemgr.out 2> /<path>/scripts/nodemgr.err &"