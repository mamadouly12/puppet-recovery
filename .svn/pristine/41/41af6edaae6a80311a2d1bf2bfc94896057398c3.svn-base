#! /bin/bash
# Script updating automatically epapyrus access groups for SVN
# ABL/OCTO 2012

#Logpath may be adapted
LOGFILE=/var/log/sync-svn-groups.log

#Don't touch anything below.
echo $(date +'%Y%m%j %T') -- Starting svn groups Synchronization >>$LOGFILE

python /usr/script/sync_ldap_groups_to_svn_authz/sync_ldap_groups_to_svn_authz.py -d "CN=EPAPYRUSWWW,OU=EPAPYRUS,OU=Comptes Applicatifs,OU=AD Corsair,DC=corsairfly,DC=com" -l "ldap://dcflysrv01.corsairfly.com:389" -b "OU=EPAPYRUS,OU=Applications,OU=Groupes Securite,OU=AD Corsair,DC=corsairfly,DC=com" -p "EpapyrussE12" -i "sAMAccountName" -g "(&(objectClass=group)(cn=*.*))" -z /var/svn/groupfile--epapyrus.conf >>/var/log/sync-svn-groups.log 2>>/var/log/sync-svn groups.log

cat /var/svn/groupfile--epapyrus.conf /var/svn/permissionfile--epapyrus.conf >/var/svn/accessfile--epapyrus.conf

chmod 644 /var/svn/accessfile--epapyrus.conf

echo $(date +'%Y%m%j %T') -- Syncing ended. >>$LOGFILE
