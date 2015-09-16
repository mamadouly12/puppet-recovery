class puppet-server {

	file {"/etc/apache2/sites-available/puppet.itcloud.lan":
		mode   => 644,
		owner  => "root",
		group  => 'root',
		notify => Service["apache2"],
		source => 'puppet:///modules/puppet-server/puppet.itcloud.lan'
	}
	
	file {
		"/var/www/puppet.itcloud.lan/":
			ensure => directory,
			mode   => 755,
			owner  => 'root',
			group  => 'root';
		"/var/www/puppet.itcloud.lan/files":
			ensure => directory,
			mode   => 755,
			owner  => 'root',
			group  => 'root';
		"/var/www/puppet.itcloud.lan/resources":
			ensure => directory,
			mode   => 755,
			owner  => 'root',
			group  => 'root';
	}

	class { 'apache2':
		enabledsites => ["puppet.itcloud.lan"],
		disabledsites => ["default","default-ssl"]
	}
	
	# Activation des modules nécessaires
	file { '/etc/apache2/mods-enabled/authnz_ldap.load':
		ensure => 'link',
		target => '../mods-available/authnz_ldap.load',
		mode   => 777,
		owner  => "root",
		group  => 'root'
	}
	file { '/etc/apache2/mods-enabled/dav.load':
		ensure => 'link',
		target => '../mods-available/dav.load',
		mode   => 777,
		owner  => "root",
		group  => 'root'
	}
	file { '/etc/apache2/mods-enabled/dav_svn.load':
		ensure => 'link',
		target => '../mods-available/dav_svn.load',
		mode   => 777,
		owner  => "root",
		group  => 'root'
	}
	file { '/etc/apache2/mods-enabled/dav_svn.conf':
		ensure => 'link',
		target => '../mods-available/dav_svn.conf',
		mode   => 777,
		owner  => "root",
		group  => 'root'
	}		
	

	# Une version récente a été installé manuellement en remplacement de la version packagée nativement disponible pour Ubuntu
	#package { "puppetmaster": 
	#	ensure => installed 
	#}
	
	service { "puppetmaster":
		enable => true,
		ensure => running
	}
	
	{ pae-puppetupdate:
		command => 'svn update /etc/puppet',
				user => root,
				minute => '*/2'
	}
}
