#!/bin/bash
# chkconfig: 345 99 4
# description: auto start/stop/status
#
. /<path>/scripts/manage.properties

PRG=$0
usage()
{
    clear
    echo "usage:$PRG ...." >&2
    echo -e "\t./manageserver [action] [server name]"
    echo -e "\t\tEx:./manageserver status oam_server1"
    echo -e "\t\taction: start, stop, status"
    echo -e "\t./manageserver [action]"
    echo -e "\t\tEx:./manageserver statusall"
    echo -e "\t\taction: startall, stopall, statusall, startohs, stopohs, statusohs, startoid, stopoid, statusoid, startnm, stopnm"
    exit 1
}

function manage_opmn()
{
   instance=$1
   action=$2
   option=$3
   if [ -d $instance ]
   then
      su - $ORACLE_OWNER -c "$instance/bin/opmnctl $action $option"
   else
      echo "There is no instance specified"
   fi
}

function manage_server()
{
   action=$1
   option=$2
   if [ -n "$SERVER_LIST" ]
   then 
     su - $ORACLE_OWNER -c "export JAVA_OPTIONS='$JAVAOPTIONS';. $DOMAIN_HOME/bin/setDomainEnv.sh $*;/<path>/Oracle/Middleware/wlserver_10.3/server/bin/setWLSEnv.sh;java $JAVA_OPTIONS -Djava.security.policy=${WL_HOME}/server/lib/weblogic.policy weblogic.WLST $SCRIPTS_HOME/server.py -a $action -m $option"
   else
     echo "There is no manageserver specified"
   fi
}

case "$1" in
 -h|--help) usage ;;
 #--------STARTING SERVER------------
 'startnm')
   su - $ORACLE_OWNER -c "$SCRIPTS_HOME/startNodeManager.sh";;
 'startohs')
   manage_opmn $OHS_INSTANCE startall;;
 'startoid')
   manage_opmn $OID_INSTANCE startall;;
 'start')
   manage_server start $2;;
 'startall')
   manage_opmn $OHS_INSTANCE startall
   manage_opmn $OID_INSTANCE startall
   manage_server start $SERVER_LIST
   ;;
 #--------STOPPING SERVER------------
 'stopnm')
   su - $ORACLE_OWNER -c "$SCRIPTS_HOME/stopNodeManager.sh";;
 'stopohs')
   manage_opmn $OHS_INSTANCE stopall;;
 'stopoid')
   manage_opmn $OID_INSTANCE stopall;;
 'stop')
   manage_server stop $2;;
 'stopall') 
   manage_server stop $SERVER_LIST
   manage_opmn $OHS_INSTANCE stopall
   manage_opmn $OID_INSTANCE stopall
   ;;
 #--------STATUS SERVER------------
 'statusohs')
   manage_opmn $OHS_INSTANCE status -l;;
 'statusoid')
   manage_opmn $OID_INSTANCE status -l;;
 'status')
   manage_server status $2;;
 'statusall')
   manage_server status $SERVER_LIST
   manage_opmn $OHS_INSTANCE status -l
   manage_opmn $OID_INSTANCE status -l 
   ;; 
esac
