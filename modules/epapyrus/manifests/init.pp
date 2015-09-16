class epapyrus( wwwdir='epapyrus-demo.corsairfly.com', env='d', envlong='demo', vip='172.18.4.33' ) {
	$epa="t${env}epaepa01"
	$ref="t${env}eparef01"
	$act="t${env}epaact01"
	
	$hostname="slv${env}epaweb01.itcloud.lan"

	# Certificats pour Java
	file { "/usr/local/java/jre/lib/security/jssecacerts":
		ensure => present,
		owner => 'root',
		group => 'root',
		mode => '644',
		source => "puppet:///modules/jdk/$hostname/jssecacerts"
	}
	
	# Groupe de service
	group {  "epapyrus":
		ensure => "present",
	}
	
	# Devrait être fait dans le module tomcat, vu que c'est ce dernier qui gére les home
	# voir carrément par l'appli
	file {"/opt/tomcat-$epa/lib/mysql-connector-java-5.1.18.jar":
		mode   => 644,
			   owner  => "tomcat-$epa",
			   group  => 'root',
			   source => 'puppet:///modules/tomcat/libs/mysql-connector-java-5.1.18.jar'
	}

	file {"/opt/tomcat-$ref/lib/mysql-connector-java-5.1.18.jar":
		mode   => 644,
			   owner  => "tomcat-$ref",
			   group  => 'root',
			   source => 'puppet:///modules/tomcat/libs/mysql-connector-java-5.1.18.jar'
	}	

	file {"/opt/tomcat-$ref/lib/jt400-7.1.0.6.jar":
		mode   => 644,
			   owner  => "tomcat-$ref",
			   group  => 'root',
			   source => 'puppet:///modules/tomcat/libs/jt400-7.1.0.6.jar'
	}
	
	file {"/opt/tomcat-$ref/lib/ojdbc6.jar":
		mode   => 644,
			   owner  => "tomcat-$ref",
			   group  => 'root',
			   source => 'puppet:///modules/tomcat/libs/ojdbc6.jar'
	}

	file {"/opt/tomcat-$act/lib/mysql-connector-java-5.1.18.jar":
		mode   => 644,
			   owner  => "tomcat-$act",
			   group  => 'root',
			   source => 'puppet:///modules/tomcat/libs/mysql-connector-java-5.1.18.jar'
	}

	file {
		"/var/www/${wwwdir}/":
			ensure => directory,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root';
		"/var/www/${wwwdir}/maintenance.html":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/epapyrus/maintenancepage/maintenance.html';
		"/var/www/${wwwdir}/maintenance.png":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/epapyrus/maintenancepage/maintenance.png';
		"/var/www/${wwwdir}/robots.txt":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/epapyrus/robots.txt';
		"/var/www/${wwwdir}/logs":
			ensure => "directory",
				   owner => root,
				   group => root,
				   mode => 644
	}

	file {
		# Déploiement du script de logging ePapyrus
		"/usr/script/parse-and-extract-epapyrus-logs.sh":
			mode   => 755,
				   owner  => 'root',
				   group  => 'root',
				   content  => template("epapyrus/parse-and-extract-epapyrus-logs.sh")
	}
	
	cron { pae-epapyrus:
		command => '/usr/script/parse-and-extract-epapyrus-logs.sh',
				user => root,
				minute => '*/2'
	}
	cron { tomcat-purge:
		command => 'for i in $(find /opt/ -iname "Catalina.out"); do date \'+%d %B %Y %T - ROTATE\' > $i; done',
				user => root,
				hour => '0',
				minute => '1'
	}

	# Fichiers d'index lucene pour TDEPAACT01
	# Amélioration : penser à mettre les cpt. de service tomcat dans un groupe
	# Attention il reste des fichiers déposés manuellement par l'équipe dev dans /var/epapyrus
	# Ce répertoire contient des XLS lus par TQEPAREF01
	file {
		"/var/epapyrus":
			ensure => "directory",
				   owner => root,
				   group => root,
				   mode => 644;
		"/var/epapyrus/index":
			ensure => "directory",
				   owner => "tomcat-$act",
				   group => "tomcat-$act",
				   mode => 644;

		"/var/epapyrus/errors":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;
 		"/var/epapyrus/errors/replay":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;
 		"/var/epapyrus/errors/activiti":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;
		"/var/epapyrus/errors/fgpnt":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;
		"/var/epapyrus/errors/vab_spider":
			ensure => "directory",
				   owner => "tomcat-$act",
				   group => "tomcat-$act",
				   mode => 755;
		"/var/epapyrus/errors/rdv_storage":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;
		"/var/epapyrus/errors/notification":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;

		"/var/epapyrus/fgpnt":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;	   
		"/var/epapyrus/stats":
			ensure => "directory",
				   owner => "tomcat-$epa",
				   group => "tomcat-$epa",
				   mode => 755;
		"/var/epapyrus/conf":
			ensure => "directory",
				   owner => "admin-crl",
				   group => "epapyrus",
				   mode => 755;	   
		"/var/epapyrus/conf/ePapyrusBO":
			ensure => "directory",
				   owner => "admin-crl",
				   group => "epapyrus",
				   mode => 755;	
		"/var/epapyrus/conf/ePapyrusReferentials":
			ensure => "directory",
				   owner => "admin-crl",
				   group => "epapyrus",
				   mode => 755;	
		"/var/epapyrus/conf/ePapyrusActiviti":
			ensure => "directory",
				   owner => "admin-crl",
				   group => "epapyrus",
				   mode => 755;	
		"/var/epapyrus/conf/ePapyrusBO/${envlong}":
			ensure => "directory",
				   owner => "admin-crl",
				   group => "epapyrus",
				   mode => 755;	
		"/var/epapyrus/conf/ePapyrusReferentials/${envlong}":
			ensure => "directory",
				   owner => "admin-crl",
				   group => "epapyrus",
				   mode => 755;	
		"/var/epapyrus/conf/ePapyrusActiviti/${envlong}":
			ensure => "directory",
				   owner => "admin-crl",
				   group => "epapyrus",
				   mode => 755
	}
	
	file{"/opt/tomcat-$epa/conf/context.xml":
		mode => '644',
		owner  => "tomcat-$epa",
		group  => 'root',
		source => "puppet:///modules/tomcat/$epa/context.xml"
	}
	
	file{"/opt/tomcat-$ref/conf/context.xml":
		mode => '644',
		owner  => "tomcat-$ref",
		group  => 'root',
		source => "puppet:///modules/tomcat/$ref/context.xml"
	}
	
	file{"/opt/tomcat-$act/conf/context.xml":
		mode => '644',
		owner  => "tomcat-$act",
		group  => 'root',
		source => "puppet:///modules/tomcat/$act/context.xml"
	}
	
	# Conf apache
	file {"/etc/apache2/sites-available/$wwwdir":
		ensure => present,
			   mode   => 644,
			   owner  => 'root',
			   group  => 'root',
			   notify => Service["apache2"],
			   content  => template("epapyrus/sites/$wwwdir")
	}

	# Nécessaire pour le SVN
	file {
			"/var/svn":
				ensure => "directory",
				owner => www-data,
				group => www-data,
				mode => 755;
			"/var/svn/docs":
				ensure => "directory",
				owner => www-data,
				group => www-data,
				mode => 755;
	}
	
	# Script de rechargement des permissions SVN régulières
	file {"/usr/script/sync_ldap_groups_to_svn_authz":
			ensure => "directory",
			owner => root,
			group => root,
			mode => 755;
	}
	file{"/usr/script/sync_ldap_groups_to_svn_authz/sync_ldap_groups_to_svn_authz.py":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/sync_ldap_groups_to_svn_authz/common/sync_ldap_groups_to_svn_authz.py"
	}
	file{"/usr/script/sync_ldap_groups_to_svn_authz/LICENSE":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/sync_ldap_groups_to_svn_authz/common/LICENSE"
	}
	file{"/usr/script/sync_ldap_groups_to_svn_authz/README":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/sync_ldap_groups_to_svn_authz/common/README"
	}
	file{"/usr/script/sync_ldap_groups_to_svn_authz/sync_ldap_groups_to_svn_authz.loader.sh":
		mode => '711',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/sync_ldap_groups_to_svn_authz/instances/$envlong/sync_ldap_groups_to_svn_authz.loader.sh"
	}
	file{"/var/svn/permissionfile--epapyrus.conf":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/sync_ldap_groups_to_svn_authz/instances/$envlong/permissionfile--epapyrus.conf"
	}
	file { "/etc/cron.hourly/sync_ldap_groups_to_svn_authz.loader.sh" :
		ensure => symlink,
		target => "/usr/script/sync_ldap_groups_to_svn_authz/sync_ldap_groups_to_svn_authz.loader.sh",
	}
	
	# scripts utiles
	file{"/usr/script/looking4inodes.sh":
		mode => '755',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/looking4inodes.sh"
	}	
	file{"/usr/script/purgeSVN.sh":
		mode => '755',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/purgeSVN.sh"
	}
	
	# SSL / Chiffrement Apache pour ePapyrus
	file{"/etc/ssl/certs/cert--$wwwdir.pem":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/certificats/$envlong/cert--$wwwdir.pem"
	}
	file{"/etc/ssl/private/key--$wwwdir.UNPROTECTED.key":
		mode => '640',
		owner  => 'root',
		group  => 'ssl-cert',
		source => "puppet:///modules/epapyrus/certificats/$envlong/key--$wwwdir.UNPROTECTED.key"
	}	
	file{"/etc/ssl/certs/thawteIntermediate.crt":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/certificats/$envlong/thawteIntermediate.crt"
	}
}
