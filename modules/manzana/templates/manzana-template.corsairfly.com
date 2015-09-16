<VirtualHost <%= vip %>:80>
	DocumentRoot /var/www/manzana<%= suffix %>.corsairfly.com
	ServerName manzana<%= suffix %>.corsairfly.com

	<Directory />
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>

	<Directory /var/www/manzana<%= suffix %>.corsairfly.com>
		AllowOverride None
		Order Deny,Allow
		Deny from all
	</Directory>

	Redirect permanent / https://manzana<%= suffix %>.crl.aero/

	LogLevel info
	ErrorLog /var/log/apache2/error--manzana<%= suffix %>.corsairfly.com.log
	CustomLog /var/log/apache2/access--manzana<%= suffix %>.corsairfly.com.log combined

</VirtualHost>

<IfModule mod_ssl.c>
	<VirtualHost <%= vip %>:443>
		DocumentRoot /var/www/manzana<%= suffix %>.corsairfly.com
		ServerName manzana<%= suffix %>.corsairfly.com
		
		<Directory />
			AllowOverride None
			Order Deny,Allow
			Deny from all
		</Directory>
	
		<Directory /var/www/manzana<%= suffix %>.corsairfly.com>
			AllowOverride None
			Order Deny,Allow
			Deny from all
		</Directory>
	                
		RedirectMatch permanent ^/$ https://manzana<%= suffix %>.crl.aero/manzana/application
		
		LogLevel info
		ErrorLog /var/log/apache2/error--ssl--manzana<%= suffix %>.corsairfly.com.log
		CustomLog /var/log/apache2/access--ssl--manzana<%= suffix %>.corsairfly.com.log combined
	
		SSLEngine on
		SSLCertificateFile    /etc/ssl/certs/ssl-cert-snakeoil.pem
	    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
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
