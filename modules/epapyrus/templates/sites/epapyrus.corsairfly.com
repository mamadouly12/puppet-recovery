<VirtualHost <%= vip %>:80>
	DocumentRoot /var/www/epapyrus.corsairfly.com
	ServerName epapyrus.corsairfly.com
	
	<Directory />
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>
	
	<Directory /var/www/epapyrus.corsairfly.com>
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>
	
	Redirect permanent / https://epapyrus.corsairfly.com/

	LogLevel info
	ErrorLog /var/log/apache2/error--epapyrus.corsairfly.com.log
	CustomLog /var/log/apache2/access--epapyrus.corsairfly.com.log combined

</VirtualHost>

<IfModule mod_ssl.c>
	<VirtualHost <%= vip %>:443>
		DocumentRoot /var/www/epapyrus.corsairfly.com
		ServerName epapyrus.corsairfly.com
			
		<Directory />
			AllowOverride None
			Order Deny,Allow
			Deny from all
		</Directory>
	
		<Directory /var/www/epapyrus.corsairfly.com>
			AllowOverride None
			Order Deny,Allow
			
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=glpepa.ecmadmin,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=glpepa.dnwriter,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=glpepa.ecmuser,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=glpepa.refreader,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=glpepa.reportwriter,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
			
			<Files "robots.txt">
				Satisfy Any
				Allow from all
			</Files>
		</Directory>
	
		<Directory /var/www/epapyrus.corsairfly.com/logs>
			AllowOverride None
			Order Deny,Allow
			
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user DSICORSAIRFLY
			Require ldap-group CN=glpepa.ecmadmin,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Directory>
	
		<Location /docs>
			ModMimeUsePathInfo On	
			DAV svn
			SVNPath /var/svn/docs
			SVNPathAuthz short_circuit
			AuthzSVNAccessFile /var/svn/accessfile--epapyrus.conf
			SVNIndexXSLT "/resources/svntemplate/view/repos.xsl"
		</Location>
	
		<Proxy *>
			Order Deny,Allow
			Allow from all
		</Proxy>
	
		ProxyRequests Off
		ProxyPreserveHost On

		# Rapports (ePapyrusBO)
		ProxyPass /epapyrus/rest http://app-t<%= env %>epaepa01:8010/epapyrus/rest
		ProxyPassReverse /epapyrus/rest http://app-t<%= env %>epaepa01:8010/epapyrus/rest
	
		# Exposition du référentiel (ePapyrusReferentials)
		ProxyPass /referentials http://app-t<%= env %>eparef01:8020/referentials
		ProxyPassReverse /referentials http://app-t<%= env %>eparef01:8020/referentials
	
		# Activiti (ePapyrusActiviti)
		ProxyPass /activiti http://app-t<%= env %>epaact01:8030/activiti
		ProxyPassReverse /activiti http://app-t<%= env %>epaact01:8030/activiti
		
		#<Directory /var/www/epapyrus.corsairfly.com/activiti/activiti>
		#	Satisfy any
		#	Allow from all
		#</Directory>
		
		<Location /epapyrus/rest>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=glpepa.reportwriter,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
	
		<Location /referentials>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=glpepa.refreader,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
		
		<Location /referentials/rest>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=glpepa.reportwriter,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
		<Location /referentials/admin/pnt>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=glpepa.dnwriter,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>	
		<Location /referentials/admin/pnc>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=glpepa.dnwriter,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
		<Location /activiti/report>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=spepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EpapyrussE12"
			AuthLDAPURL "ldap://ldp-gdimza.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=glpepa.reportwriter,OU=epapyrus-prod,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>

		LogLevel info
		ErrorLog /var/log/apache2/error--epapyrus.corsairfly.com.log
		CustomLog /var/log/apache2/svn--epapyrus.corsairfly.com.log "%t - user=%u - repos=%{SVN-REPOS-NAME}e - action=%{SVN-ACTION}e" env=SVN-ACTION
		CustomLog /var/log/apache2/access--epapyrus.corsairfly.com.log combined
	
		SSLEngine on
		SSLCertificateFile    /etc/ssl/certs/cert--epapyrus.corsairfly.com.pem
		SSLCertificateChainFile /etc/ssl/certs/thawteIntermediate.crt
		SSLCertificateKeyFile /etc/ssl/private/key--epapyrus.corsairfly.com.UNPROTECTED.key
		SSLProtocol -all +SSLv3 +TLSv1
		SSLCipherSuite RC4-SHA:AES128-SHA:HIGH:!aNULL:!EXP:!MD5:!NULL
		SSLHonorCipherOrder on
		SSLStrictSNIVHostCheck off
	
		BrowserMatch "MSIE [2-6]" \
		nokeepalive ssl-unclean-shutdown \
		downgrade-1.0 force-response-1.0
		BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown

	</VirtualHost>
</IfModule>
