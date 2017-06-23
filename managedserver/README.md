Oracle Managed Servers Startup Scripts
======================================
Setting Up
----------
1. Give a right permission to the scripts
   
        chmod 700 <path>/scripts/startup <path>/scripts/server.py <path>/scripts/manageserver.sh

1. Move startup script to init.d folder

        sudo mv <path>/scripts/startup /etc/init.d/startup

1. Add startup script to startup process

        sudo /sbin/chkconfig --add startup -- level 0356

1. Test the scripts

        sudo <path>/scripts/manageservers.sh -h
        sudo /sbin/service startup startall
        sudo /sbin/service startup stopall
        sudo reboot
