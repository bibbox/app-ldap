

su

# load backend modules "back_ldap", "back_meta", "rwm"

ldapadd -Y EXTERNAL -H ldapi:/// -f 0_moduleLoad.ldif
------------------------------------------------------------------------
dn: cn=module{0},cn=config
changetype: modify
add: olcModuleLoad
olcModuleLoad: back_ldap
-
add: olcModuleLoad
olcModuleLoad: back_meta
-
add: olcModuleLoad
olcModuleLoad: rwm
------------------------------------------------------------------------

restart? dont remember



# add mug ldap login directory to your ldap as database

ldapadd -Y EXTERNAL -H ldapi:/// -f 1_ldap_database.ldif

------------------------------------------------------------------------
dn: olcDatabase=ldap,cn=config
objectClass: olcLDAPConfig
olcDatabase: ldap
olcSuffix: ou=pers,ou=usr,o=mug
olcDbURI: "ldap://ldap.medunigraz.at"
------------------------------------------------------------------------



# "overlay" mug ldap bind request over my own database

ldapadd -Y EXTERNAL -H ldapi:/// -f 2_rwm_activate.ldif

------------------------------------------------------------------------
dn: olcOverlay=rwm,olcDatabase={-1}frontend,cn=config
objectClass: olcOverlayConfig
objectClass: olcRwmConfig
olcOverlay: rwm
olcRwmRewrite: rwm-rewriteEngine "on"
olcRwmRewrite: rwm-rewriteContext "bindDN"
olcRwmRewrite: rwm-rewriteRule "^uid=(o_.+),ou=people,dc=ngslab$" "cn=$1,ou=pers,ou=usr,o=mug" ":@"
olcRwmTFSupport: no
olcRwmNormalizeMapped: FALSE
------------------------------------------------------------------------


