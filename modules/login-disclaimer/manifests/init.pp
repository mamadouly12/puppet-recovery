class login-disclaimer {

	file { "/etc/motd.tail":
		source  => "puppet://puppet/login-disclaimer/motd.tail",
	}
}
