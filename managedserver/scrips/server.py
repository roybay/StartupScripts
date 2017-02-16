#!/usr/bin/python

import sys
import getopt
import ConfigParser
#------------------------------------------------------------
def input_validation(argv):
  action = ''
  managedservers = ''

  try:
    opts, args = getopt.getopt(argv,"ha:m:",["action=", "managedservers="])
  except getopt.GetoptError:
    print 'server.py -a <action> -m <managedservers>'
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print 'server.py -a <action> -m <managedservers>'
      sys.exit()
    elif opt in ("-a", "--action"):
      action = arg
    elif opt in ("-m", "--managedservers"):
      managedservers = arg
      managedservers = managedservers.split(",")  
  print 'Action is ', action
  print 'ManagedServers are ', managedservers
  return (action, managedservers)
#------------------------------------------------------------
def startServer(managedservers):
  nmConnect(userConfigFile=nmconfig + 'nm.config', userKeyFile=nmconfig + 'nm.key', host=localhost, port=portnumber, domainName=domainname, domainDir=domainhome + domainname, nmType='ssl')

  for managedserver in managedservers:
    print "Starting "+  managedserver
    nmStart(serverName=managedserver)
  nmDisconnect();
  exit()
#------------------------------------------------------------
def stopServer(managedservers):
  nmConnect(userConfigFile=nmconfig + 'nm.config', userKeyFile=nmconfig + 'nm.key', host=localhost, port=portnumber, domainName=domainname, domainDir=domainhome + domainname, nmType='ssl')
  
  managedservers.reverse()
  for managedserver in managedservers:
    print "Stopping "+  managedserver
    nmKill(serverName=managedserver)
  nmDisconnect();
  exit()
#------------------------------------------------------------
def statusServer(managedservers):
  nmConnect(userConfigFile=nmconfig + 'nm.config', userKeyFile=nmconfig + 'nm.key', host=localhost, port=portnumber, domainName=domainname, domainDir=domainhome + domainname, nmType='ssl')
  
  for managedserver in managedservers:
    print "Checking status of "+  managedserver
    managedServerStatus = nmServerStatus(serverName=managedserver)
    print "\n"
    print managedserver + ": " + managedServerStatus
  nmDisconnect();
  exit()
#------------------------------------------------------------
if __name__=='__main__' or __name__== 'main':
  config = ConfigParser.ConfigParser()
  config.readfp(open(r'/opt/oracle/scripts/server.properties'))
  
  domainname = config.get('Server_Properties','domainname')
  localhost = config.get('Server_Properties','localhost')
  portnumber = config.getint('Server_Properties','portnumber')
  nmconfig = config.get('Server_Properties','nmconfig')
  domainhome = config.get('Server_Properties','domainhome')
  
  action, managedservers = input_validation(sys.argv[1:]);

  if   action == 'start':
       startServer(managedservers);
  elif action == 'stop':
       stopServer(managedservers);
  elif action == 'status':
       statusServer(managedservers);
  exit();
