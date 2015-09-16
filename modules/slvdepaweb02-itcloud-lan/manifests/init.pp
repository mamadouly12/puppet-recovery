class slvdepaweb02-itcloud-lan {

	# Serveur Apache
	################

	class { 'apache2':
		enabledsites => ["app-alfresco-demo.itcloud.lan"],
		disabledsites => ["default","default-ssl"]
	}

	# Serveur Tomcat
	################

	package { "tomcat6":
		ensure => installed
	}

	file { "/etc/default/tomcat6":
		source  => "puppet://puppet/slvdepaweb02-itcloud-lan/tomcat6",
		owner => root,
		group => root,
		mode => 644,
	}

	service { "tomcat6":
		ensure => running
	}

	file { "/etc/tomcat6/server.xml":
		source  => "puppet://puppet/slvdepaweb02-itcloud-lan/server.xml",
		owner => root,
		group => tomcat6,
		mode => 644,
	}

	file { "/etc/tomcat6/tomcat-users.xml":
		source  => "puppet://puppet/slvdepaweb02-itcloud-lan/tomcat-users.xml",
		owner => root,
		group => tomcat6,
		mode => 640,
	}

	file { "/etc/tomcat6/jmxremote.password":
		source  => "puppet://puppet/slvdepaweb02-itcloud-lan/jmxremote.password",
		owner => tomcat6,
		group => tomcat6,
		mode => 600,
	}

	file { "/etc/tomcat6/jmxremote.access":
		source  => "puppet://puppet/slvdepaweb02-itcloud-lan/jmxremote.access",
		owner => tomcat6,
		group => tomcat6,
		mode => 600,
	}

	# Requis pour Alfresco
	######################

	package { "swftools":
		ensure => installed
	}

	package { "imagemagick":
		ensure => installed
	}

	package { "ffmpeg":
		ensure => installed
	}

	file { "/opt/sources":
		ensure => "directory",
		owner => root,
		group => root,
		mode => 644,
	}

	# Module SSO pour Alfresco Core
	###############################
	class { 'sso-alfresco': envlong => 'demo', suffix => '-demo'}
}
