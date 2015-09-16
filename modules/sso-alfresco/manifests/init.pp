class sso-alfresco(suffix='-demo', envlong='demo', vip='172.18.4.24') {
	
	#envlong should be either demo / preprod / prod.
	#suffix contains the dns host suffix : -demo for demo, -preprod for preprod, nothing for prod.
	
	$wwwdir="share${suffix}.crl.aero"
	
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
				   source => 'puppet:///modules/sso-alfresco/maintenancepage/maintenance.html';
		"/var/www/${wwwdir}/maintenance.png":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/sso-alfresco/maintenancepage/maintenance.png';
	}	

	file {"/etc/apache2/sites-available/share$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("sso-alfresco/share$suffix.crl.aero-template")
	}

	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/${wwwdir}/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_share_$envlong.crl.aero.key":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_share_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_share_$envlong.crl.aero.cert":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_share_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_share_$envlong.crl.aero.xml":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_share_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}
	
	
	file {
		"/var/www/records${suffix}.crl.aero/":
			ensure => directory,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root';		   
		"/var/www/records${suffix}.crl.aero/maintenance.html":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/sso-alfresco/maintenancepage/maintenance.html';
		"/var/www/records${suffix}.crl.aero/maintenance.png":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/sso-alfresco/maintenancepage/maintenance.png';
	}	

	file {"/etc/apache2/sites-available/records$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("sso-alfresco/records$suffix.crl.aero-template")
	}

	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/records${suffix}.crl.aero/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/records${suffix}.crl.aero/https_records_$envlong.crl.aero.key":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_records_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/records${suffix}.crl.aero/https_records_$envlong.crl.aero.cert":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_records_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/records${suffix}.crl.aero/https_records_$envlong.crl.aero.xml":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_records_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}
	
	file {
		"/var/www/ebiblio${suffix}.crl.aero/":
			ensure => directory,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root';		   
		"/var/www/ebiblio${suffix}.crl.aero/maintenance.html":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/sso-alfresco/maintenancepage/maintenance.html';
		"/var/www/ebiblio${suffix}.crl.aero/maintenance.png":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/sso-alfresco/maintenancepage/maintenance.png';
	}	

	file {"/etc/apache2/sites-available/ebiblio$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("sso-alfresco/ebiblio$suffix.crl.aero-template")
	}

	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/ebiblio${suffix}.crl.aero/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/ebiblio${suffix}.crl.aero/https_ebiblio_$envlong.crl.aero.key":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_ebiblio_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/ebiblio${suffix}.crl.aero/https_ebiblio_$envlong.crl.aero.cert":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_ebiblio_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/ebiblio${suffix}.crl.aero/https_ebiblio_$envlong.crl.aero.xml":
			source  => "puppet://puppet/sso-alfresco/$envlong/https_ebiblio_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}
	
	
	
}