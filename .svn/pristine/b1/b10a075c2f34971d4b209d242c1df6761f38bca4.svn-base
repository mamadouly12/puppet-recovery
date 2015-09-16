class slvqepaweb01-itcloud-lan {

	# Update ABL/31/01/2013 : deploy certificates for *.crl.aero
	class { 'certificate-crlaero': }

	#Update ABL 06/02/2013 : externalize shared conf for apache SSO client conf
	class {'apache2ssoclient': envlong => 'preprod'}

	# Update ABL/31/01/2013 : add crewlink site
	class { 'apache2':
		enabledsites => ["ebiblio-preprod.crl.aero","share-preprod.crl.aero", "records-preprod.crl.aero","epapyrus-preprod.corsairfly.com","manzana-preprod.corsairfly.com","manzana-preprod.crl.aero","login-preprod.crl.aero","go-preprod.crl.aero","visual-preprod.crl.aero","kiosque-preprod.crl.aero"],
		disabledsites => ["default","default-ssl"]
	}
	
	class { 'jdk': version_maj => '6', version_min => '27', arch => 'i586' }
	
	file { "/etc/environment":
		source  => "puppet://puppet/slvqepaweb01-itcloud-lan/environment",
		owner => root,
		group => root,
		mode => 644,
	}
	
	# Les déclarations de toutes les instances tomcat se font ici car elles doivent toutes êtres groupées
	$epa="tqepaepa01"
	$ref="tqeparef01"
	$act="tqepaact01"
	$mza="tqgdimza01"
	$sso="tqgdisso01"
	$sch="tqepasch01"
	$rep="tqeparep01"
	$bib="tqepabib01"
	
	class { 'tomcat':
		nick => [ $epa,$ref,$act,$mza,$sso,$sch,$rep,$bib ],
		catalina_opts => {
			"$epa" => '-Xms512M -Xmx512M -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC',
			"$ref" => '-Xms512M -Xmx512M -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC',
			"$act" => '-Xms1024M -Xmx1024M -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC',
			"$mza" => '-Xms512M -Xmx512M -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC',
			"$sso" => '-Xms1024M -Xmx1024M -server -Xss132K -XX:PermSize=96m -XX:MaxPermSize=96m -Dsun.net.client.defaultReadTimeout=60000 -Dsun.net.client.defaultConnectTimeout=30000 -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:+CMSClassUnloadingEnabled',
			"$sch" => '-Xms512M -Xmx512M',
			"$rep" => '-Xms512M -Xmx512M',
			"$bib" => '-Xms512M -Xmx512M'
		},
		jmxremote => {
			"$epa" => '8011',
			"$ref" => '8021',
			"$act" => '8031',
			"$mza" => '8041',
			"$sso" => '8051',
			"$sch" => '8061',
			"$rep" => '8071',
			"$bib" => '8081'
		}
	}
	
	class { 'epapyrus': env => 'q', envlong => 'preprod', wwwdir => 'epapyrus-preprod.corsairfly.com', vip => '172.18.4.33'}
	class { 'manzana': env => 'q', envlong => 'preprod', suffix => '-preprod', vip => '172.18.4.24'}
	class { 'sso': env => 'q', suffix => '-preprod', wwwdir => 'login-preprod.crl.aero', vip => '172.18.4.24'}
	class { 'landingpage': envlong => 'preprod', suffix => '-preprod', vip => '172.18.4.24'}
	class { 'visual': env => 'q', envlong => 'preprod', suffix => '-preprod', vip => '172.18.4.24'}
	class { 'sso-alfresco': envlong => 'preprod', suffix => '-preprod', vip => '172.18.4.24'}
}
