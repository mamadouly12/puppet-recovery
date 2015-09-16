class certificate-crlaero {

	# This class deploys the key/certificate *.crl.aero on the requested server

	# Private key file
	file{
		"/etc/ssl/private/STAR.crl.aero.key":
			mode => 640,
			owner  => 'root',
			group  => 'ssl-cert',
			source => "puppet://puppet/certificate-crlaero/certificatesandkeys/STAR.crl.aero.key"
	}
	
	# Certificate itself
	file{
		"/etc/ssl/certs/STAR.crl.aero.crt":
			mode => 644,
			owner  => 'root',
			group  => 'root',
			source => "puppet://puppet/certificate-crlaero/certificatesandkeys/STAR.crl.aero.crt"
	}

	# Full certification chain
	file{
		"/etc/ssl/certs/ComodoCertificateChain.crt":
			mode => 644,
			owner  => 'root',
			group  => 'root',
			source => "puppet://puppet/certificate-crlaero/certificatesandkeys/ComodoCertificateChain.crt"
	}		
}