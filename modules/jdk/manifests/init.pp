# $Id$
# vim6:ts=2:sw=2:syntax=ruby

# Attention le package ne s'est pas déployé tout seul, il fallait lancer puppetd sur le client avec sudo su	
# ATTENTION /etc/environment a du etre mis à jour manuellement !!!!!

class jdk( $version_maj='6', $version_min='27', $arch='i586' )
{
	Exec {
		path => [
			'/usr/bin',
			'/bin',
			'/usr/local/bin'
				]
	}
	$jdk_basename=$version_maj ? {
			'6' => "jdk-${version_maj}u${version_min}-linux-${arch}.bin",
			'7' => "jdk-${version_maj}u${version_min}-linux-${arch}.tar.gz"
	}
	$jdk_file="/var/cache/$jdk_basename"
	exec {
		"install jdk":
			cwd     => '/usr/local',
			creates => "/usr/local/java/bin/java",
			command => $version_maj ? {
				'7' => "tar -xzf ${jdk_file}",
				'6' => "sh ${jdk_file}"
				},
			require => File["${jdk_file}"];
		'dl jdk':
			# si wget est interrompu, le téléchargement ne se refera pas (et c'est mal mais c'est le seul moyen pour qu'il ne retélécharge pas à chaque fois)
			creates => "${jdk_file}",
			command => "wget http://puppet.itcloud.lan/files/${jdk_basename} -O ${jdk_file}"
	}

	file{
		"/usr/local/java":
			ensure => link,
			# Si version_min < 10, ca plante : il faut rajouter un 0 après '_'
			target => $version_min ? {
				'27' => "/usr/local/jdk1.${version_maj}.0_${version_min}",
				'6'  => "/usr/local/jdk1.${version_maj}.0_0${version_min}",
			},
			require => Exec['install jdk'];
		"/etc/profile.d/java.sh":
			content  => "export JAVA_HOME=/usr/local/java\nexport PATH=\$PATH:\$JAVA_HOME/bin";
		"${jdk_file}":
			ensure => present,
			require => Exec['dl jdk']
	}
	# il faut s'assurer qu'openjdk n'est pas installé
	package {
		"openjdk-6-jdk":
			ensure => absent;
		"openjdk-6-jre-headless":
			ensure => absent;	
		"gcj-jdk":
			ensure => absent;
	}
}
