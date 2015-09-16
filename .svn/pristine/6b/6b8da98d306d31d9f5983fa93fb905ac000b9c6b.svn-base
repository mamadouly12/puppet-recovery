class ntp {

	package { "ntp": 
		ensure => installed 
	}

	file { "/etc/ntp.conf":
		source  => "puppet://puppet/ntp/ntp.conf",
		require => Package[ntp]
	}

	service { "ntp":
		enable => true,
		ensure => running
	}
}
