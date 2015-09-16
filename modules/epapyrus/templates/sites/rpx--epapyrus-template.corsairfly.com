<VirtualHost <%= vipepapyrus %>:80>
	DocumentRoot /var/www/default
	ServerName epapyrus<%= suffix %>.corsairfly.com
	
	<Directory />
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>
	
	<Directory /var/www/default>
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>
	
	Redirect permanent / https://epapyrus<%= suffix %>.corsairfly.com/

	LogLevel info
	ErrorLog /var/log/apache2/error--epapyrus<%= suffix %>.corsairfly.com.log
	CustomLog /var/log/apache2/access--epapyrus<%= suffix %>.corsairfly.com.log combined

</VirtualHost>

<IfModule mod_ssl.c>
	<VirtualHost <%= vipepapyrus %>:443>
		DocumentRoot /var/www/default
		ServerName epapyrus<%= suffix %>.corsairfly.com
			
		<Directory />
			AllowOverride None
			Order Deny,Allow
			Deny from all
		</Directory>
        
		<Directory /var/www/default>
			AllowOverride None
			Order Deny,Allow
			Deny from all
        </Directory>

		SSLProxyEngine on
		ProxyRequests Off
		ProxyPreserveHost On

		<Proxy *>
			Order allow,deny
			Allow from all
		</Proxy>

		ProxyPass /docs https://epapyrus<%= suffix %>.corsairfly.com/docs
		ProxyPassReverse /docs https://epapyrus<%= suffix %>.corsairfly.com/docs
		
		ProxyPass /epapyrus/rest https://epapyrus<%= suffix %>.corsairfly.com/epapyrus/rest
		ProxyPassReverse /epapyrus/rest https://epapyrus<%= suffix %>.corsairfly.com/epapyrus/rest
		# Prevents ePapyrusBO's replay feature to be accessible from the internet (via DMZ)
		<Location /epapyrus/rest/replay>
			Order Deny,Allow
			Deny from all
		</Location>

		ProxyPass /resources https://epapyrus<%= suffix %>.corsairfly.com/resources
		ProxyPassReverse /resources https://epapyrus<%= suffix %>.corsairfly.com/resources
		
		ProxyPass /download https://epapyrus<%= suffix %>.corsairfly.com/download
		ProxyPassReverse /download https://epapyrus<%= suffix %>.corsairfly.com/download
		
		ProxyPass /referentials https://epapyrus<%= suffix %>.corsairfly.com/referentials
		ProxyPassReverse /referentials https://epapyrus<%= suffix %>.corsairfly.com/referentials
		
		ProxyPass /activiti https://epapyrus<%= suffix %>.corsairfly.com/activiti
		ProxyPassReverse /activiti https://epapyrus<%= suffix %>.corsairfly.com/activiti
		# Prevents ePapyrusActiviti's resolve feature to be accessible from the internet  (via DMZ)
		<Location /activiti/rest/resolve>
			Order Deny,Allow
			Deny from all
		</Location>

		LogLevel info
		ErrorLog /var/log/apache2/error--epapyrus<%= suffix %>.corsairfly.com.log
		CustomLog /var/log/apache2/access--epapyrus<%= suffix %>.corsairfly.com.log combined
	
		SSLEngine on
		SSLCertificateFile    /etc/ssl/certs/cert--epapyrus<%= suffix %>.corsairfly.com.pem
		SSLCertificateChainFile /etc/ssl/certs/thawteIntermediate.crt
		SSLCertificateKeyFile /etc/ssl/private/key--epapyrus<%= suffix %>.corsairfly.com.UNPROTECTED.key
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
