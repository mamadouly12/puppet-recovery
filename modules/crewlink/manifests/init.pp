class crewlink(suffix='-demo', envlong='demo', vip='172.18.4.24') {
	
	#envlong should be either demo / preprod / prod.
	#suffix contains the dns host suffix : -demo for demo, -preprod for preprod, nothing for prod.
	
	$wwwdir="crewlink${suffix}.crl.aero"
	
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
				   source => 'puppet:///modules/crewlink/maintenancepage/maintenance.html';
		"/var/www/${wwwdir}/maintenance.png":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/crewlink/maintenancepage/maintenance.png';
	}	

	file {"/etc/apache2/sites-available/crewlink$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("crewlink/crewlink-template.crl.aero")
	}

	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/${wwwdir}/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_crewlink_$envlong.crl.aero.key":
			source  => "puppet://puppet/crewlink/$envlong/https_crewlink_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_crewlink_$envlong.crl.aero.cert":
			source  => "puppet://puppet/crewlink/$envlong/https_crewlink_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_crewlink_$envlong.crl.aero.xml":
			source  => "puppet://puppet/crewlink/$envlong/https_crewlink_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}
}