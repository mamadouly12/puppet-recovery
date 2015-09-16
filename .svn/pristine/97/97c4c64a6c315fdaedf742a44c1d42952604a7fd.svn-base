class mysql ( conf='default.my.cnf', backupuser='root', backuppwd='', backupbdd='mysql') {

	package { "mysql-server-5.1": 
		ensure => installed 
	}
	
	# Configuration
	file {"/etc/mysql/my.cnf":
		mode   => 644,
		owner  => 'root',
		group  => 'root',
		content  => template("mysql/$conf")
	}

	service { "mysql":
		enable => true,
		ensure => running
	}

	#Backup folder is /var/mysqlbackup, only reachable by root
	file {"/var/mysqlbackup":
		ensure => "directory",
		owner => root,
		group => admin-crl,
		mode => 750	
	}

	#Midnight's backup
	cron { BDD-BACKUPS-MIDNIGHT:
		ensure  => present,
		# tmp, le / stature
		#command => "mysqldump --host=localhost --port=3389 --user=$backupuser --password=$backuppwd --single-transaction --databases $backupbdd | gzip >/var/mysqlbackup/backup-midnight-$(date +\%u).gz",
		command => "mysqldump --host=localhost --port=3389 --user=$backupuser --password=$backuppwd --single-transaction --databases $backupbdd | gzip >/var/mysqlbackup/backup-midnight.gz",
		user => 'root',
		hour => '1',
		minute => '0'
	}

	#Backup achieved at lunch time	
	cron { BDD-BACKUPS-MIDDAY:
		ensure  => present,
		# tmp, le / stature
		#command => "mysqldump --host=localhost --port=3389 --user=$backupuser --password=$backuppwd --single-transaction --databases $backupbdd | gzip >/var/mysqlbackup/backup-midday-$(date +\%u).gz",
		command => "mysqldump --host=localhost --port=3389 --user=$backupuser --password=$backuppwd --single-transaction --databases $backupbdd | gzip >/var/mysqlbackup/backup-midday.gz",
		user => 'root',
		hour => '13',
		minute => '0'
	}
}
