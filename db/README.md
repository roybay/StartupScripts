Oracle DB Startup Scripts
=========================
Setting Up
----------
1. Modify oratab
   
        vi /etc/oratab
        Ex: orcl:/<path>/Oracle/product/11.2.0/dbhome_1:Y
   
1. Give a right permission to the scripts
   
        chmod 700 /<path>/scripts/db_start.sh /<path>/scripts/db_stop.sh /<path>/scripts/em_start.sh /<path>/scripts/em_stop.sh /<path>/scripts/dbora

1. Move dbora to init.d folder

        sudo mv /<path>/scripts/dbora /etc/init.d/dbora

1. Add dbora to startup process

        sudo /sbin/chkconfig --add dbora

1. Test the scripts

        sudo /sbin/service dbora start
        sudo /sbin/service dbora stop
        sudo reboot
