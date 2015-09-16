class demosite(suffix='-demo') {
	
	$wwwdir="demosite${suffix}.crl.aero"
	
	file {
		"/var/www/${wwwdir}/":
			ensure => directory,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root';		   
		"/var/www/${wwwdir}/index.html":
			ensure => present,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root',
				   source => 'puppet:///modules/demosite/page/index.html';
	}	

	file {"/etc/apache2/sites-available/demosite$suffix.crl.aero":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		notify => Service["apache2"],
		content  => template("demosite/demosite-template.crl.aero")
	}
}