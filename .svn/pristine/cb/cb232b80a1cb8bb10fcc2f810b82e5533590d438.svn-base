class dns-server-master {

	package { "bind9": 
		ensure => installed 
	}
	
	file { "/etc/bind/named.conf.local":
		source  => "puppet://puppet/dns-server-master/named.conf.local",
		owner => root,
		group => bind,
		mode => 644,
		notify => Service[bind9]
	}
	
	file { "/etc/bind/named.conf.options":
		source  => "puppet://puppet/dns-server-master/named.conf.options",
		owner => root,
		group => bind,
		mode => 644,
		notify => Service[bind9]
	}
	
	file { "/etc/bind/db.itcloud.lan":
		source  => "puppet://puppet/dns-server-master/db.itcloud.lan",
		owner => root,
		group => bind,
		mode => 644,
		notify => Service[bind9]
	}
	
	file { "/etc/bind/db.crl.aero":
		source  => "puppet://puppet/dns-server-master/db.crl.aero",
		owner => root,
		group => bind,
		mode => 644,
		notify => Service[bind9]
	}
	
	file { "/etc/bind/db.172.18":
		source  => "puppet://puppet/dns-server-master/db.172.18",
		owner => root,
		group => bind,
		mode => 644,
		notify => Service[bind9]
	}

	file { "/etc/bind/db.10.160":
		source  => "puppet://puppet/dns-server-master/db.10.160",
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
