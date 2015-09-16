#!/bin/bash

NB_LINE_OF_LOGS=200
tail -n $NB_LINE_OF_LOGS /opt/tomcat-<%= epa %>/logs/catalina.out >/var/www/<%= wwwdir %>/logs/<%= epa %>-catalina-last.log
tail -n $NB_LINE_OF_LOGS /opt/tomcat-<%= ref %>/logs/catalina.out >/var/www/<%= wwwdir %>/logs/<%= ref %>-catalina-last.log
tail -n $NB_LINE_OF_LOGS /opt/tomcat-<%= act %>/logs/catalina.out >/var/www/<%= wwwdir %>/logs/<%= act %>-catalina-last.log

tail -n $NB_LINE_OF_LOGS /var/log/tomcat6/EPAPYRUSACTIVITI.log >/var/www/<%= wwwdir %>/logs/EPAPYRUSACTIVITI-last.log
tail -n $NB_LINE_OF_LOGS /var/log/tomcat6/EPAPYRUSBO.log >/var/www/<%= wwwdir %>/logs/EPAPYRUSBO-last.log
tail -n $NB_LINE_OF_LOGS /var/log/tomcat6/EPAPYRUSREFERENTIALS.log >/var/www/<%= wwwdir %>/logs/EPAPYRUSREFERENTIALS-last.log
