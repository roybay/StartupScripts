#!/bin/bash
# chkconfig: 345 99 4
# description: stop nodemanager
#
echo "Stopping Node Manger"
kill -9 `ps -ef | grep [N]odeManager | awk '{print $2}'`
