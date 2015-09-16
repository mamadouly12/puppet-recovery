$zabbix_user_parameters = []

class zabbix-agent {
	
	$fqdn=inline_template("<%= fqdn.downcase %>")
    
    package { "zabbix-agent":
            ensure => installed
    }
    
    file {
		"/etc/zabbix/zabbix_agentd.conf":
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			content  => template("zabbix-agent/zabbix_agentd.conf")
	}

    file {
		"/etc/zabbix/zabbix_agent.conf":
			mode   => 644,
			owner  => 'root',
			group  => 'root',
			content  => template("zabbix-agent/zabbix_agent.conf")
	}

    service { "zabbix-agent":
    		enable => true,
            ensure => running
    }
}
