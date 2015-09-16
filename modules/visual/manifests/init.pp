class visual(suffix='-demo', envlong='demo', vip='172.18.4.24', env='d') {
	
	#envlong should be either demo / preprod / prod.
	#suffix contains the dns host suffix : -demo for demo, -preprod for preprod, nothing for prod.
	
	$wwwdir="visual${suffix}.crl.aero"
	
	# Contenu du site web visual.crl.aero
	file {
		"/var/www/${wwwdir}/":
			ensure => directory,
			mode   => 644,
			owner  => 'SDEPAUDD01',
			group  => 'root';
	}

	file {"/etc/apache2/sites-available/visual$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("visual/visual$suffix.crl.aero")
	}
	
	file {"/var/www/visual$suffix.crl.aero/robots.txt":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		source  => "puppet://puppet/visual/robots.txt"
	}

	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/${wwwdir}/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_visual_$envlong.crl.aero.key":
			source  => "puppet://puppet/visual/$envlong/https_visual_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_visual_$envlong.crl.aero.cert":
			source  => "puppet://puppet/visual/$envlong/https_visual_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_visual_$envlong.crl.aero.xml":
			source  => "puppet://puppet/visual/$envlong/https_visual_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}
	
	
}