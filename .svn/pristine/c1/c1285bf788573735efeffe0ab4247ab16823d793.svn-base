class apache2ssoclient(envlong='demo') {

	# This class deploys anything required to run mod_mellon module (the SAML Service provider SSO module)

	# Prerequisite packages
	package { "libxmlsec1": 
		ensure => installed 
	}
	package { "libxmlsec1-openssl": 
		ensure => installed 
	}
	
	package { "libxslt1.1": 
		ensure => installed 
	}	
	
	package { "libcurl3": 
		ensure => installed 
	}
	
	package { "liblasso3": 
		ensure => installed 
	}
	
	# Deploy setup script
	file {
		"/usr/script/sso-mellon":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'root';		
		"/usr/script/sso-mellon/mellon_create_metadata.sh":
			source  => "puppet://puppet/apache2ssoclient/mellon_create_metadata.sh",
			mode => 750,
			owner => 'root',
			group => 'root';
	}	
	
	# copy Apache Module prior to any installation
	# To be then installed manually
	file {
		"/var/cache/libapache2-mod-auth-mellon_0.4.0-1_i386.deb":
			source  => "puppet://puppet/apache2ssoclient/libapache2-mod-auth-mellon_0.4.0-1_i386.deb",
			mode => 640,
			owner => 'root',
			group => 'root';
	}		

	# IDP meta data files
	file {
		"/etc/apache2/sso-mellon":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';
		"/etc/apache2/sso-mellon/sites":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';					   
		"/etc/apache2/sso-mellon/idp-data":
			ensure => directory,
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';				   
		"/etc/apache2/sso-mellon/idp-data/idp-cert.pem":
			source  => "puppet://puppet/sso/idppublicdata/$envlong/idp-cert.pem",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';	
		"/etc/apache2/sso-mellon/idp-data/idp-metadata.xml":
			source  => "puppet://puppet/sso/idppublicdata/$envlong/idp-metadata.xml",
			mode   => 640,
			owner  => 'root',
			group  => 'www-data';	
	}	
}