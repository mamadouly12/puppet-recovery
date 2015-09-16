class ssh {

	package { "ssh": 
		ensure => installed 
	}

	service { "ssh":
		enable => true,
		ensure => running
	}
}
