# nodes.pp
##########

## Configuration générique

class basenode {

	file {
		"/usr/script":
			ensure => directory,
			mode   => 755,
			owner  => 'root',
			group  => 'root';
	}
	
	class { 'dns': }
	class { 'login-disclaimer': }
	class { 'ntp': }
	class { 'puppet': }
	class { 'zabbix-agent': }
	class { 'ssh': }
	class { 'promptcolor': }
	class { 'pam': }
}
node tomcatservernode {}

## 1. INFRA
###########
node 'slvpinfcnf01.itcloud.lan' {
	class { 'basenode': }
	class { 'puppet-server': }	
}

node 'slvpinfpxy01.itcloud.lan' { class { 'basenode': } } # Overrider la conf NTP !
node 'slvpinfsys01.itcloud.lan' {
	class { 'basenode': }
	class { 'dns-server-secondary': }	
}
node 'slvpinfsys02.itcloud.lan' { class { 'basenode': } }
node 'slvpinfsys03.itcloud.lan' {
	class { 'basenode': }
	class { 'dns-server-master': }
}
node 'slvpepaudd01.itcloud.lan' { class { 'basenode': } }

## 2. DEMO
###########
node 'slvdepaweb01.itcloud.lan' {
	class { 'basenode': }
	class { 'slvdepaweb01-itcloud-lan': }
}
node 'slvdepaweb02.itcloud.lan' { class { 'basenode': } 
	include slvdepaweb02-itcloud-lan	
}
node 'slvdinfbdd01.itcloud.lan' {
	class { 'basenode': }
	class { 'mysql':
		backupuser =>'root',
		backuppwd=>'a$pi2012',
		backupbdd=>'MDEPAEPA01 MDEPAACT01 MDEPAREF01 MDEPAREF02 MDGDIEVE01 MDGDIEVE02 MDGDIMZA01 MDGDIWFL01 BDDDETESTVAB mysql'
	}
}

## 3. PREPROD
#############
node 'slvqepaweb01.itcloud.lan' {
	class { 'basenode': }
	class { 'slvqepaweb01-itcloud-lan': }
}
node 'slvqepaweb02.itcloud.lan' { class { 'basenode': } }
node 'slvqinfbdd01.itcloud.lan' {
	class { 'basenode': }
	class { 'mysql':
		conf =>'windowssetup.my.cnf',
		backupuser =>'root',
		backuppwd=>'a$pi2012',
		backupbdd=>'MQEPAEPA01 MQEPAACT01 MQEPAREF01 MQEPAREF02 MQGDIEVE01 MQGDIMZA01 MQGDIWFL01 mysql'
	}
}
node 'slvqinfrpx01.itcloud.lan' {
	class { 'basenode': }
	class { 'reverseproxies': suffix =>'-preprod', envlong => 'preprod', vip =>'172.18.1.25', vipepapyrus =>'172.18.1.33' }
}
node 'slvqepabdd01.itcloud.lan' { class { 'basenode': } }

node 'CFY-PP-WEB01' { class { 'basenode': } }

## 4. PROD
###########
node 'slvpepaweb01.itcloud.lan' {
	class { 'basenode': }
	class { 'slvpepaweb01-itcloud-lan': }
}
node 'slvpepaweb02.itcloud.lan' { class { 'basenode': } }
node 'slvpinfbdd01.itcloud.lan' {
	class { 'basenode': }
	class { 'mysql':
		backupuser =>'root',
		backuppwd=>'PRODa\$pi2012',
		backupbdd=>'MPEPAEPA01 MPEPAACT01 MPEPAREF01 MPEPAREF02 MPGDIEVE01 MPGDIMZA01 MPGDIWFL01 MPEPAPYRUSVAB01 mysql'
	}
}
node 'slvpinfrpx01.itcloud.lan' {
	class { 'basenode': }
	class { 'reverseproxies': suffix =>'', envlong => 'production', vip =>'172.18.1.26', vipepapyrus =>'172.18.1.34' }
}


