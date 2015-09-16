#!/bin/bash
#
# $Id: tomcatinitd.sh 35 2011-03-14 08:17:23Z amz $
#
### BEGIN INIT INFO
# Provides:          tomcat-<%= tomcat_nick %>
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Should-Start:      $named
# Should-Stop:       $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start Tomcat-<%= tomcat_nick %>
# Description:       Start the Tomcat-<%= tomcat_nick %> servlet engine.
### END INIT INFO

#
# 

TOMCAT_LOCATION="/opt/tomcat-<%= tomcat_nick %>"
CURRENT_USER=$(id -un)
VALID_USER="<%= tomcat_user %>"
CATALINA_OPTS="<%= catalina_opts %>"



_stopStartAll()
{

	action=$1
	shift
	if [ $CURRENT_USER == $VALID_USER ]
	then	
		RUNUSER="" 
	elif [ -x "/sbin/runuser" ]
	then
		RUNUSER="/sbin/runuser $VALID_USER"
	else
		# Better used 'su -' but I need to keep CATALINA_OPTS
		RUNUSER="su $VALID_USER --"
	fi		
	case $action in
		start)
			CATALINA_OPTS="$CATALINA_OPTS" $RUNUSER $TOMCAT_LOCATION/bin/startup.sh ;;
		stop)
			$RUNUSER $TOMCAT_LOCATION/bin/shutdown.sh ;;
		*)
			echo "\"$action\" ??" ;;
	esac

}




case $1 in
	start|stop)
	_stopStartAll $*
	;;
	restart)
	shift 
	$0 stop
	$0 start
	;;
	status)
		uids=$(ps -U $VALID_USER -o uid 2>/dev/null | grep -v UID | xargs)
		if [ -n "$uids" ]
		then
			echo "Tomcat-<%= tomcat_nick %> running ($uids)"
		else
			echo "Tomcat-<%= tomcat_nick %> NOT running"
			exit 1
		fi
		;;
	*)
	echo "Usage: $0 (start|stop|restart)"
esac

exit $?  
