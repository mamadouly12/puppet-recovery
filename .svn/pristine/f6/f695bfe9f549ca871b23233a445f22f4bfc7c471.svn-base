# $Id$
# vim6:ts=2:sw=2:syntax=ruby

class jre( $version_maj='6', $version_min='32', $arch='i586' )
{
	Exec {
		path => [
			'/usr/bin',
			'/bin',
			'/usr/local/bin'
				]
	}
	$jre_basename=$version_maj ? {
			'6' => "jre-${version_maj}u${version_min}-linux-${arch}.bin",
			'7' => "jre-${version_maj}u${version_min}-linux-${arch}.tar.gz"
	}
	$jre_file="/var/cache/$jre_basename"
	exec {
		"install jre":
			cwd     => '/usr/local',
			creates => "/usr/local/java/bin/java",
			command => $version_maj ? {
				'7' => "tar -xzf ${jre_file}",
				'6' => "sh ${jre_file}",
				},
			require => File["${jre_file}"];
		'dl jre':
			# si wget est interrompu, le téléchargement ne se refera pas (et c'est mal mais c'est le seul moyen pour qu'il ne retélécharge pas à chaque fois)
			creates => "${jre_file}",
			command => "wget http://puppet.itcloud.lan/files/${jre_basename} -O ${jre_file}"
	}

	file{
		"/usr/local/java":
			ensure => link,
			# Si version_min < 10, ca plante : il faut rajouter un 0 après '_'
			target => $version_min ? {
				'32' => "/usr/local/jre1.${version_maj}.0_${version_min}",
				'6'  => "/usr/local/jre1.${version_maj}.0_0${version_min}",
			},
			require => Exec['install jre'];
		"/etc/profile.d/java.sh":
			content  => "export JAVA_HOME=/usr/local/java\nexport PATH=\$PATH:\$JAVA_HOME/bin";
		"${jre_file}":
			ensure => present,
			require => Exec['dl jre']
	}
	# il faut s'assurer qu'openjdk n'est pas installé
	package {
		"openjdk-6-jre":
			ensure => absent;
		"gcj-jre":
			ensure => absent;
	}
}
