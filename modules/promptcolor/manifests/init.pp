class promptcolor {

	file { "/usr/script/promptcolor":
		ensure => "directory",
		owner => root,
		group => root,
		mode => 755,
	}	

	file { "/usr/script/promptcolor/promptcolor.sh":
		source  => "puppet://puppet/promptcolor/promptcolor.sh",
		owner => root,
		group => root,
		mode => 755,
	}
	
	file { "/etc/cron.hourly/promptcolor.sh" :
		ensure => symlink,
		target => "/usr/script/promptcolor/promptcolor.sh",
	}
}
