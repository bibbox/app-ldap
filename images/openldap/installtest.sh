apt-get update
apt-get upgrade
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d
apt-get install slapd ldap-utils
PW: fenris

apt-get install vim

vi /etc/ldap/ldap.conf
-----------------START: /etc/ldap/ldap.conf-------------------
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

#BASE   dc=example,dc=com
#URI    ldap://ldap.example.com ldap://ldap-master.example.com:666

BASE dc=digipat
URI ldap://openldap ldap:openldap:666

#SIZELIMIT      12
#TIMELIMIT      15
#DEREF          never

# TLS certificates (needed for GnuTLS)
TLS_CACERT      /etc/ssl/certs/ca-certificates.crt
-----------------END: /etc/ldap/ldap.conf-------------------


dpkg-reconfigure slapd
dns: openldap
organization: digipat
PW: fenris
DB: MDB


slapcat -d -1
slapd -d -1