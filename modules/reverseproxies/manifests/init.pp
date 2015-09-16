class reverseproxies (suffix='-preprod', envlong='preprod', vip='172.18.1.25', vipepapyrus='172.18.1.33' ) {

	# Update ABL/31/01/2013 : deploy certificates for *.crl.aero
	class { 'certificate-crlaero': }

	## APACHE
	class { 'apache2':
		enabledsites => ["share$suffix.crl.aero","ebiblio$suffix.crl.aero","records$suffix.crl.aero","epapyrus$suffix.corsairfly.com","crewlink$suffix.crl.aero","manzana$suffix.crl.aero","splunk$suffix.crl.aero","go$suffix.crl.aero","kiosque$suffix.crl.aero","visual$suffix.crl.aero","aw$suffix.crl.aero"],
		disabledsites => ["default","default-ssl"]
	}

	# Déploiement du reverse proxy epapyrus
	file {
		"/etc/apache2/sites-available/epapyrus$suffix.corsairfly.com":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("epapyrus/sites/rpx--epapyrus-template.corsairfly.com")
	}
	
	# SSL / Chiffrement Apache pour ePapyrus
	file{"/etc/ssl/certs/cert--epapyrus$suffix.corsairfly.com.pem":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/certificats/$envlong/cert--epapyrus$suffix.corsairfly.com.pem"
	}
	file{"/etc/ssl/private/key--epapyrus$suffix.corsairfly.com.UNPROTECTED.key":
		mode => '640',
		owner  => 'root',
		group  => 'ssl-cert',
		source => "puppet:///modules/epapyrus/certificats/$envlong/key--epapyrus$suffix.corsairfly.com.UNPROTECTED.key"
	}	
	file{"/etc/ssl/certs/thawteIntermediate.crt":
		mode => '644',
		owner  => 'root',
		group  => 'root',
		source => "puppet:///modules/epapyrus/certificats/$envlong/thawteIntermediate.crt"
	}
	
	# Déploiement des fichiers propres au LOGIN / SSO
	file{
		"/etc/apache2/sites-available/login$suffix.crl.aero":
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			content  => template("sso/rpx--login-template.crl.aero");
	}	
	
	# Déploiement du reverse proxy Crewlink
	file {
		"/etc/apache2/sites-available/crewlink$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("crewlink/rpx--crewlink-template.crl.aero")
	}
	
	# Déploiement du reverse proxy eBiblio
	file {
		"/etc/apache2/sites-available/ebiblio$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("sso-alfresco/rpx--ebiblio-template.crl.aero")
	}	
	
	# Déploiement du reverse proxy Manzana
	file {
		"/etc/apache2/sites-available/manzana$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("manzana/rpx--manzana-template.crl.aero")
	}
	
	# Déploiement du reverse proxy Share
	file {
		"/etc/apache2/sites-available/share$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("sso-alfresco/rpx--share-template.crl.aero")
	}	
	
	# Déploiement du reverse proxy Splunk
	file {
		"/etc/apache2/sites-available/splunk$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("splunk/rpx--splunk-template.crl.aero")
	}		
	
	# Déploiement du reverse proxy Records
	file {
		"/etc/apache2/sites-available/records$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("sso-alfresco/rpx--records-template.crl.aero")
	}	
				
	# Déploiement du reverse proxy LandingPage
	file {
		"/etc/apache2/sites-available/go$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("landingpage/rpx--go-template.crl.aero")
	}

        # Déploiement du reverse proxy Kiosque
        file {
                "/etc/apache2/sites-available/kiosque$suffix.crl.aero":
                mode   => 644,
                owner  => 'root',
                group  => 'root',
                notify => Service["apache2"],
                content  => template("landingpage/rpx--kiosque-template.crl.aero")
        }

	# Déploiement du reverse proxy Visual
	file {
		"/etc/apache2/sites-available/visual$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("visual/rpx--visual-template.crl.aero")
	}
	
	# Déploiement du reverse proxy Airwatch
	file {
		"/etc/apache2/sites-available/aw$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("airwatch/rpx--aw-template.crl.aero")
	}
	
	## LDAP
	
	package { "slapd": 
		ensure => installed 
	}

	file { "/etc/ldap/slapd.conf":
		content  => template("reverseproxies/slapd$suffix.conf"),
		mode => '644',
		owner  => 'root',
		group  => 'root',
		require => Package[slapd]
	}

	file { "/etc/default/slapd":
		content  => template("reverseproxies/slapd"),
		mode => '644',
		owner  => 'root',
		group  => 'root',
		require => Package[slapd]
	}

	service { "slapd":
		enable => true,
		ensure => running
	}
}
