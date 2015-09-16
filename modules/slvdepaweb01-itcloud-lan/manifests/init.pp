class slvdepaweb01-itcloud-lan {

	class { 'apache2':
		enabledsites => ["share-demo.crl.aero", "records-demo.crl.aero","epapyrus-demo.corsairfly.com","manzana-demo.corsairfly.com","manzana-demo.crl.aero","login-demo.crl.aero","go-demo.crl.aero","kiosque-demo.crl.aero","visual-demo.crl.aero"],
		disabledsites => ["default","default-ssl"]
	}

        # Update CSI-20130930 - Déploiement des certificats *.crl.aero
        class { 'certificate-crlaero': }
	
	#Update ABL 06/02/2013 : externalize shared conf for apache SSO client conf
	class {'apache2ssoclient': envlong => 'demo'}
	
	class { 'jdk': version_maj => '6', version_min => '27', arch => 'i586' }
	
	file { "/etc/environment":
		source  => "puppet://puppet/slvdepaweb01-itcloud-lan/environment",
		owner => root,
		group => root,
		mode => 644,
	}
	
	# Les déclarations de toutes les instances tomcat se font ici car elles doivent toutes êtres groupées
	$epa="tdepaepa01"
	$ref="tdeparef01"
	$act="tdepaact01"
	$mza="tdgdimza01"
	$sso="tdgdisso01"
	$sch="tdepasch01"
	$rep="tdeparep01"
	$bib="tdepabib01"
	
	class { 'tomcat':
		nick => [ $epa,$ref,$act,$mza,$sso,$sch,$rep,$bib],
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

	class { 'epapyrus': env => 'd', envlong => 'demo', wwwdir => 'epapyrus-demo.corsairfly.com', vip => '172.18.3.33'}
	class { 'manzana': env => 'd', envlong => 'demo', suffix => '-demo', vip => '172.18.3.33'}
	class { 'sso': env => 'd', suffix => '-demo', wwwdir => 'login-demo.crl.aero', vip => '172.18.3.33'}
	class { 'landingpage': envlong => 'demo', suffix => '-demo', vip => '172.18.3.33'}
	class { 'visual': env => 'd', envlong => 'demo', suffix => '-demo', vip => '172.18.3.33'}
	class { 'sso-alfresco': envlong => 'demo', suffix => '-demo', vip => '172.18.3.33'}
}
