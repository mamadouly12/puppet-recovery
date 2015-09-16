class slvpepaweb01-itcloud-lan {

	# Update ABL/31/01/2013 : deploy certificates for *.crl.aero
	class { 'certificate-crlaero': }

	#Update ABL 06/02/2013 : externalize shared conf for apache SSO client conf
	class {'apache2ssoclient': envlong => 'prod'}

	# Update ABL/31/01/2013 : add crewlink site
	class { 'apache2':
		enabledsites => ["ebiblio.crl.aero","share.crl.aero", "records.crl.aero","epapyrus.corsairfly.com","manzana.corsairfly.com","manzana.crl.aero","login.crl.aero","crewlink.crl.aero","splunk.crl.aero","go.crl.aero","visual.crl.aero","kiosque.crl.aero"],
		disabledsites => ["default","default-ssl"]
	}
	
	class { 'jdk': version_maj => '6', version_min => '27', arch => 'i586' }
	
	file { "/etc/environment":
		source  => "puppet://puppet/slvpepaweb01-itcloud-lan/environment",
		owner => root,
		group => root,
		mode => 644,
	}
	
	# Les déclarations de toutes les instances tomcat se font ici car elles doivent toutes êtres groupées
	$epa="tpepaepa01"
	$ref="tpeparef01"
	$act="tpepaact01"
	$mza="tpgdimza01"
	$sso="tpgdisso01"
	$sch="tpepasch01"
	$rep="tpeparep01"
	$bib="tpepabib01"
	
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
	
	class { 'epapyrus': env => 'p', envlong => 'production', wwwdir => 'epapyrus.corsairfly.com', vip => '172.18.5.33'}
	class { 'manzana': env => 'p', envlong => 'prod', suffix => '', vip => '172.18.5.24'}
	class { 'sso': env => 'p', suffix => '', wwwdir => 'login.crl.aero', vip => '172.18.5.24'}
	class { 'crewlink': suffix=>'', envlong=>'prod', vip => '172.18.5.24'}
	class { 'sso-alfresco': envlong => 'prod', suffix => '', vip => '172.18.5.24'}
	class { 'splunk': suffix=>'', envlong=>'prod', vip => '172.18.5.24'}
	class { 'visual': env => 'p', envlong => 'prod', suffix => '', vip => '172.18.5.24'}
	class { 'landingpage': envlong => 'prod', suffix => '', vip => '172.18.5.24'}
}
