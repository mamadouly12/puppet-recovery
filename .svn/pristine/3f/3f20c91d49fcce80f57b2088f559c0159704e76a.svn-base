class manzana(env='d', envlong='demo', suffix='-demo', vip='172.18.4.24') {
	
	$wwwdir="manzana${suffix}.crl.aero"
	$mza="t${env}gdimza01"
	$fqdn=inline_template("<%= fqdn.downcase %>")
	
	file {"/opt/tomcat-$mza/lib/mysql-connector-java-5.1.18.jar":
		mode   => 644,
		owner  => "tomcat-$epa",
		group  => 'root',
		source => 'puppet:///modules/tomcat/libs/mysql-connector-java-5.1.18.jar'
	}
	
	file {
			"/var/www/${wwwdir}/":
				ensure => directory,
					   mode   => 644,
					   owner  => 'root',
					   group  => 'root';
			"/var/www/${wwwdir}/form":
				ensure => directory,
					   mode   => 644,
					   owner  => 'root',
					   group  => 'root';		   
			"/var/www/${wwwdir}/maintenance.html":
				ensure => present,
					   mode   => 644,
					   owner  => 'root',
					   group  => 'root',
					   source => 'puppet:///modules/manzana/maintenancepage/maintenance.html';
			"/var/www/${wwwdir}/maintenance.png":
				ensure => present,
					   mode   => 644,
					   owner  => 'root',
					   group  => 'root',
					   source => 'puppet:///modules/manzana/maintenancepage/maintenance.png';
		}
		
	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/${wwwdir}/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_manzana_$envlong.crl.aero.key":
			source  => "puppet://puppet/manzana/$envlong/https_manzana_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_manzana_$envlong.crl.aero.cert":
			source  => "puppet://puppet/manzana/$envlong/https_manzana_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_manzana_$envlong.crl.aero.xml":
			source  => "puppet://puppet/manzana/$envlong/https_manzana_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}
	
	# Configuration nouveau site WWW
	file {
		# Déploiement du template de site web
		"/etc/apache2/sites-available/$wwwdir":
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			content  => template("manzana/manzana$suffix.crl.aero")
	}
	
	# Ancien site WWW maintenu temporairement pour avoir une redirection vers le nouveau site
	file {
		"/var/www/manzana$suffix.corsairfly.com":
			ensure => directory,
			mode   => 644,
			owner  => 'root',
			group  => 'root';
		"/etc/apache2/sites-available/manzana$suffix.corsairfly.com":
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			content  => template("manzana/manzana-template.corsairfly.com")
	}
}
