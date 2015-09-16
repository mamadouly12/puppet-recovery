# $Id$

class tomcat( $version_maj='6', $version_min='0', $version_patch='35', $nick='anderson', $catalina_opts='', $limits_soft_nofile='2048', $limits_hard_nofile='2048', $jmxremote )
{
	include concat::setup
	$version_full="${version_maj}.${version_min}.${version_patch}"

	# Ajouter un répertoire /opt => ca ferait bien mieux d'être dans le script de création tomcat comme prérequis avec DEPENDANCE !!!
	file { "/opt":
		ensure => "directory",
		owner => root,
		group => root,
		mode => 755
	}
	
	file {
		"/var/log/tomcat6":
			ensure => "directory",
			owner => root,
			group => root,
			mode => 777;
	}
	
	concat{"/etc/security/limits.d/tomcat_limits.conf":
    	owner => root,
    	group => root,
    	mode  => 644
	}
	Exec {
		path => [
			'/usr/bin',
			'/bin',
			'/usr/local/bin'
				]
	}

	define installTomcat {
		$tomcat_service = "tomcat-${name}"
		$tomcat_jmxremote = $jmxremote[$name]
		$tomcat_home = "/opt/${tomcat_service}"
		$tomcat_initd= "/etc/init.d/${tomcat_service}"
		$tomcat_user="${tomcat_service}"
		$tomcat_nick="${name}"
		notice( "${name}" )
		$catalina_opts="${catalina_opts[$name]} -Dcom.sun.management.jmxremote.port=${tomcat_jmxremote} -Dcom.sun.management.jmxremote.password.file=${tomcat_home}/conf/jmxremote.password -Dcom.sun.management.jmxremote.access.file=${tomcat_home}/conf/jmxremote.access -Dcom.sun.management.jmxremote.ssl=false"
		file { "${tomcat_home}":
					ensure  => present,
					owner => "${tomcat_user}",
					require => Exec["install $tomcat_service"];
				"${tomcat_home}/logs":
					owner => "${tomcat_user}",
					require => Exec["install $tomcat_service"];
				"${tomcat_home}/conf/jmxremote.password":
					owner => "${tomcat_user}",
					mode  => '400',
					source  => "puppet:///modules/tomcat/${tomcat_nick}/jmxremote.password",
					require => Exec["install $tomcat_service"];
				"${tomcat_home}/conf/jmxremote.access":
					owner => "${tomcat_user}",
					source  => "puppet:///modules/tomcat/${tomcat_nick}/jmxremote.access",
					require => Exec["install $tomcat_service"];
				"${tomcat_home}/conf/server.xml":
					owner => "${tomcat_user}",
					source  => "puppet:///modules/tomcat/${tomcat_nick}/server.xml",
					require => Exec["install $tomcat_service"];
				"${tomcat_home}/conf/tomcat-users.xml":
					owner => "${tomcat_user}",
					source  => "puppet:///modules/tomcat/${tomcat_nick}/tomcat-users.xml",
					require => Exec["install $tomcat_service"];
				"${tomcat_home}/conf":
					owner => "${tomcat_user}",
					require => Exec["install $tomcat_service"];
			}
    	concat::fragment{ "tomcat_limits_fragment_${tomcat_nick}":
        	target  => "/etc/security/limits.d/tomcat_limits.conf",
        	content => "$tomcat_user	soft	nofile	$limits_soft_nofile\n$tomcat_user	hard	nofile	$limits_hard_nofile\n",
        	order   => 50,
        	ensure  => 'present'
		}
		file {"${tomcat_initd}":
			ensure => present,
			mode   => 755,
			owner  => 'root',
			group  => 'root',
			content   => template('tomcat/tomcatinitd.sh'),
			require =>  File['/usr/local/java']
		}
		exec {"install $tomcat_service":
			command => "tar -C /opt -xzf /var/cache/apache-tomcat-${version_full}.tar.gz; mv /opt/apache-tomcat-${version_full} /opt/$tomcat_service ; chown -R ${tomcat_user} /opt/$tomcat_service  ",
			creates => "${tomcat_home}",
			require => File["/var/cache/apache-tomcat-${version_full}.tar.gz"]
		}
		user {"${tomcat_user}":
			ensure => present,
			home => "${tomcat_home}",
			shell => '/bin/sh'
		}
		service {"${tomcat_service}":
			enable => true,
			ensure => running,
			# si le init.d change ou si le java change, redémarrage
			subscribe => [ File["${tomcat_initd}"], File["/usr/local/java"], File["/etc/security/limits.d/tomcat_limits.conf"] ]
		}
	}
	installTomcat { $nick: }
	file { "/var/cache/apache-tomcat-${version_full}.tar.gz":
		ensure => present,
		require => Exec["dl tomcat"]
	}
	exec {'dl tomcat':
		creates => "/var/cache/apache-tomcat-${version_full}.tar.gz",
		command => "wget  http://puppet.itcloud.lan/files/apache-tomcat-${version_full}.tar.gz -O /var/cache/apache-tomcat-${version_full}.tar.gz",
	}

}
