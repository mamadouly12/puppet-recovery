class puppet {

	package { "puppet": 
		ensure => installed 
	}
	
	# remark : file /etc/puppet/puppet.conf not handled already, since it hasn't been customized so far.
	
	file { "/etc/default/puppet":
		source  => "puppet://puppet/puppet/puppet",
		require => Package[puppet]
	}

	service { "puppet":
		ensure => stopped
	}
}
