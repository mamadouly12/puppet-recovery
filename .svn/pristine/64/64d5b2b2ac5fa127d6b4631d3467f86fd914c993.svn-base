class landingpage(suffix='-demo', envlong='demo', vip='172.18.4.24') {
	
	#envlong should be either demo / preprod / prod.
	#suffix contains the dns host suffix : -demo for demo, -preprod for preprod, nothing for prod.
	
	$wwwdir="go${suffix}.crl.aero"
	$wwwdir2="kiosque${suffix}.crl.aero"
	
	# Contenu du site web go.crl.aero
	file {
		"/var/www/${wwwdir}/":
			ensure => present,
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			source => "puppet://puppet/landingpage/siteweb",
			ignore => ".svn",
  			recurse => true;
	}

	# Contenu du site web kiosque.crl.aero
	file {
                "/var/www/${wwwdir2}/":
                        ensure => present,
                        mode   => 644,
                        owner  => 'root',
                        group  => 'root',
                        source => "puppet://puppet/landingpage/kiosque",
                        ignore => ".svn",
                        recurse => true;
        }

	file {"/etc/apache2/sites-available/go$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("landingpage/go$suffix.crl.aero")
	}

	file {"/etc/apache2/sites-available/kiosque$suffix.crl.aero":
                mode   => 644,
                owner  => 'root', 
                group  => 'root', 
                notify => Service["apache2"],
                content  => template("landingpage/kiosque$suffix.crl.aero")
        }

	# SP meta data
	file {
		"/etc/apache2/sso-mellon/sites/${wwwdir}/":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_go_$envlong.crl.aero.key":
			source  => "puppet://puppet/landingpage/$envlong/https_go_$envlong.crl.aero.key",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_go_$envlong.crl.aero.cert":
			source  => "puppet://puppet/landingpage/$envlong/https_go_$envlong.crl.aero.cert",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites/${wwwdir}/https_go_$envlong.crl.aero.xml":
			source  => "puppet://puppet/landingpage/$envlong/https_go_$envlong.crl.aero.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
	}

        # SP meta data kiosque
        file {  
                "/etc/apache2/sso-mellon/sites/${wwwdir2}/":
                        ensure => directory,
                        mode   => 640,
                        owner  => 'root',
                        group  => 'www-data';
                "/etc/apache2/sso-mellon/sites/${wwwdir2}/https_kiosque_$envlong.crl.aero.key":
                        source  => "puppet://puppet/landingpage/$envlong/https_kiosque_$envlong.crl.aero.key",
                        mode   => 640,
                        owner  => 'root',
                        group  => 'www-data';
                "/etc/apache2/sso-mellon/sites/${wwwdir2}/https_kiosque_$envlong.crl.aero.cert":
                        source  => "puppet://puppet/landingpage/$envlong/https_kiosque_$envlong.crl.aero.cert",
                        mode   => 640,
                        owner  => 'root',
                        group  => 'www-data';
                "/etc/apache2/sso-mellon/sites/${wwwdir2}/https_kiosque_$envlong.crl.aero.xml":
                        source  => "puppet://puppet/landingpage/$envlong/https_kiosque_$envlong.crl.aero.xml",
                        mode   => 640,
                        owner  => 'root',
                        group  => 'www-data';
        }    	
	
}
