class sso( wwwdir='login-demo.crl.aero', env='d', suffix='-demo', vip='172.18.4.24') {
	
	$fqdn=inline_template("<%= fqdn.downcase %>")
	$sso="t${env}gdisso01"
	
	file {
			"/var/www/${wwwdir}/":
				ensure => directory,
					   mode   => 644,
					   owner  => 'root',
					   group  => 'root';
			"/var/www/${wwwdir}/maintenance.html":
				ensure => present,
					   mode   => 644,
					   owner  => 'root',
					   group  => 'root',
					   source => 'puppet:///modules/manzana/maintenancepage/maintenance.html';
			"/var/www/${wwwdir}/maintenance.png":
				ensure => present,
					   mode   => 644,
					   owner  => 'root',
					   group  => 'root',
					   source => 'puppet:///modules/manzana/maintenancepage/maintenance.png';
	}
		
	file {
		# Déploiement du template de site web
		"/etc/apache2/sites-available/$wwwdir":
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			notify => Service["apache2"],
			content  => template("sso/login$suffix.crl.aero")
	}

	file {
		# Déploiement openSSO
		"/opt/tomcat-${sso}/webapps/opensso.war":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => 'root',
			source  => "puppet://puppet/sso/opensso.war",
	}
	
	# Customized files after .WAR deployment
	file {
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default_fr/DataStore.xml":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/DataStore.fr.xml";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default_en/DataStore.xml":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/DataStore.en.xml";
		"/opt/tomcat-${sso}/webapps/opensso/css/new_style.css":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/new_style.css";
		"/opt/tomcat-${sso}/webapps/opensso/WEB-INF/web.xml":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/web.xml";
		"/opt/tomcat-${sso}/webapps/opensso/401.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/401.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/images/logoCorsair.png":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/logoCorsair.png";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/disclaimer.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/disclaimer.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/Login.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/Login.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/membership.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/membership.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/new_org.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/new_org.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/OAuthActivate.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/OAuthActivate.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/OAuthPwd.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/OAuthPwd.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/profileError.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/profileError.jsp";
		"/opt/tomcat-${sso}/webapps/opensso/config/auth/default/register.jsp":
			mode   => 644,
			owner  => "tomcat-${sso}",
			group  => "tomcat-${sso}",
			source  => "puppet://puppet/sso/customizationwarfiles/register.jsp";
	}
}
