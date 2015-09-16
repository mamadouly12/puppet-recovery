class dns-server-secondary {

	package { "bind9": 
		ensure => installed 
	}
	
	file { "/etc/bind/named.conf.local":
		source  => "puppet://puppet/dns-server-secondary/named.conf.local",
		owner => root,
		group => bind,
		mode => 644,
		notify => Service[bind9]
	}
	
	file { "/etc/bind/named.conf.options":
		source  => "puppet://puppet/dns-server-secondary/named.conf.options",
		owner => root,
		group => bind,
		mode => 644,
		notify => Service[bind9]
	}
		
	service { "bind9":
		enable => true,
		ensure => running
	}
}
