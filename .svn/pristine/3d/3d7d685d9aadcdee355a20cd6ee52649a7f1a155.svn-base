class splunk(suffix='-demo', envlong='demo', vip='172.18.4.24') {
	
	#envlong should be either demo / preprod / prod.
	#suffix contains the dns host suffix : -demo for demo, -preprod for preprod, nothing for prod.
	
	$wwwdir="splunk${suffix}.crl.aero"
	
	file {
		"/var/www/${wwwdir}/":
			ensure => directory,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root';		   
	}

	file {"/etc/apache2/sites-available/splunk$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("splunk/splunk-template.crl.aero")
	}
	
	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/${wwwdir}/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_splunk_$envlong.crl.aero.key":
			source  => "puppet://puppet/splunk/$envlong/https_splunk_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_splunk_$envlong.crl.aero.cert":
			source  => "puppet://puppet/splunk/$envlong/https_splunk_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_splunk_$envlong.crl.aero.xml":
			source  => "puppet://puppet/splunk/$envlong/https_splunk_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}
}