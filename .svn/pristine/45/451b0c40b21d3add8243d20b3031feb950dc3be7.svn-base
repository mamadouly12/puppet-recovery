<VirtualHost <%= vip %>:80>
	DocumentRoot /var/www/epapyrus-demo.corsairfly.com
	ServerName epapyrus-demo.corsairfly.com
	
	<Directory />
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>
	
	<Directory /var/www/epapyrus-demo.corsairfly.com>
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>
	
	Redirect permanent / https://epapyrus-demo.corsairfly.com/

	LogLevel info
	ErrorLog /var/log/apache2/error--epapyrus-demo.corsairfly.com.log
	CustomLog /var/log/apache2/access--epapyrus-demo.corsairfly.com.log combined

</VirtualHost>

<IfModule mod_ssl.c>
	<VirtualHost <%= vip %>:443>
	    DocumentRoot /var/www/epapyrus-demo.corsairfly.com
		ServerName	epapyrus-demo.corsairfly.com
		
		<Directory />
			AllowOverride None
			Order Deny,Allow
			Deny from all
		</Directory>
	
		<Directory /var/www/epapyrus-demo.corsairfly.com>
			AllowOverride None
			Order Deny,Allow
			
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=sdepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EPAPYRUSWWW"
			AuthLDAPURL "ldap://ldp-gdimza-demo.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=gldepa.ecmadmin,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=gldepa.dnwriter,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=gldepa.ecmuser,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=gldepa.refreader,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
			Require ldap-group CN=gldepa.reportwriter,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
			
			<Files "robots.txt">
				Satisfy Any
				Allow from all
			</Files>
		</Directory>
	
		<Directory /var/www/epapyrus-demo.corsairfly.com/logs>
			AllowOverride None
			Order Deny,Allow
			
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=sdepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EPAPYRUSWWW"
			AuthLDAPURL "ldap://ldp-gdimza-demo.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user DSICORSAIRFLY
			Require ldap-group CN=gldepa.ecmadmin,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Directory>
	
		<Location /docsfitnesse>
			ModMimeUsePathInfo On
			DAV svn
			SVNPath /var/svn/docsfitnesse
			AuthzSVNAccessFile /var/svn/accessfile--fitnesse.conf
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
		
		<Location /epapyrus/rest>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=sdepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EPAPYRUSWWW"
			AuthLDAPURL "ldap://ldp-gdimza-demo.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=gldepa.reportwriter,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
		
		<Location /referentials>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=sdepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EPAPYRUSWWW"
			AuthLDAPURL "ldap://ldp-gdimza-demo.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=gldepa.refreader,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
		        
		<Location /referentials/rest>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=sdepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EPAPYRUSWWW"
			AuthLDAPURL "ldap://ldp-gdimza-demo.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=gldepa.reportwriter,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
		<Location /referentials/admin/pnc>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=sdepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EPAPYRUSWWW"
			AuthLDAPURL "ldap://ldp-gdimza-demo.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=gldepa.dnwriter,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
		
		<Location /activiti/report>
			ModMimeUsePathInfo On
			AuthType Basic
			AuthzLDAPAuthoritative off
			AuthBasicProvider ldap
			AuthName "Veuillez vous authentifier"
			AuthLDAPBindDN "CN=sdepawww02,OU=serviceaccounts,OU=technical,O=manzana"
			AuthLDAPBindPassword "EPAPYRUSWWW"
			AuthLDAPURL "ldap://ldp-gdimza-demo.itcloud.lan:33389/O=manzana?uid?sub?(|(objectClass=userProxyFull)(objectClass=inetOrgPerson))"
			Require ldap-user EPAPYRUSWWW
			Require ldap-group CN=gldepa.reportwriter,OU=epapyrus-demo,OU=epapyrus,OU=applications,OU=groups,O=manzana
		</Location>
	
		LogLevel info
		ErrorLog /var/log/apache2/error--epapyrus-demo.corsairfly.com.log
		CustomLog /var/log/apache2/svn--epapyrus-demo.corsairfly.com.log "%t - user=%u - repos=%{SVN-REPOS-NAME}e - action=%{SVN-ACTION}e" env=SVN-ACTION
		CustomLog /var/log/apache2/access--epapyrus-demo.corsairfly.com.log combined
	
		SSLEngine on
		SSLCertificateFile    /etc/ssl/certs/cert--epapyrus-demo.corsairfly.com.pem
		SSLCertificateChainFile /etc/ssl/certs/thawteIntermediate.crt
		SSLCertificateKeyFile /etc/ssl/private/key--epapyrus-demo.corsairfly.com.UNPROTECTED.key
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
