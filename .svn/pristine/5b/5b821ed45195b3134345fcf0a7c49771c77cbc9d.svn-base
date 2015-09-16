class apache2 ($enabledsites, $disabledsites)
{
	$fqdn=inline_template("<%= fqdn.downcase %>")

	$wantedpackages = ["apache2"]
	package { $wantedpackages: ensure => installed, }

	define site ( $ensure = 'present' ) {
		case $ensure {
			'present' : {
				exec { "/usr/sbin/a2ensite $name":
					unless => "/bin/readlink -e ${apache2_sites}-enabled/$name",
					#notify => Exec["reload-apache2"],
					require => Package["apache2"]
				}
			}
			'absent' : {
				exec { "/usr/sbin/a2dissite $name":
					onlyif => "/bin/readlink -e ${apache2_sites}-enabled/$name",
					#notify => Exec["reload-apache2"],
					require => Package["apache2"]
				}
			}
			default: { err ( "Unknown ensure value: '$ensure'" ) }
		}
	}

	apache2::site {
		$enabledsites: ensure => 'present';
		$disabledsites: ensure => 'absent';
	}    

	file {
		"/etc/apache2/apache2.conf":
			ensure => present,
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			source => "puppet:///modules/apache2/$fqdn/apache2.conf"
	}
	file {
		"/etc/apache2/ports.conf":
			ensure => present,
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			source => "puppet:///modules/apache2/$fqdn/ports.conf"
	}
	file{
		"/etc/apache2/sites-available/default":
			ensure => present,
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			content  => template("apache2/default")
	}
	file{
		"/etc/apache2/sites-available/default-ssl":
			ensure => present,
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			content  => template("apache2/default-ssl")
	}	
	
	file {
		"/var/www/default/":
			ensure => directory,
				   mode   => 644,
				   owner  => 'root',
				   group  => 'root'
	}
	
	file{
		"/var/www/default/index.htm":
			ensure => present,
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			source => "puppet:///modules/apache2/index.htm"
	}	
		
	service{"apache2":
		ensure => 'running'
	}
}
