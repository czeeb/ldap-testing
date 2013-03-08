Exec {
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ]
}

include apt

package { "vim":
  ensure => present,
}

package { "git":
  ensure => present,
}

# LDAP Server
package { "slapd": 
  ensure => present,
}

package { "ldap-utils":
  ensure => present,
}

package { "phpldapadmin":
  ensure => present,
}

# LDAP Client
package { "nscd":
  ensure => present,
}

package { 'libpam-ldap':
  ensure => present,
}

file { 
  '/etc/ldap.conf':
    require => Package["libpam-ldap"],
    ensure  => present,
    source  => "/vagrant/puppet/files/ldap-client.conf";
  '/etc/ldap.secret':
    require => Package["libpam-ldap"],
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0600,
    source => "/vagrant/puppet/files/ldap-client.secret";
  '/etc/nsswitch.conf':
    require => Package["libpam-ldap"],
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    source => "/vagrant/puppet/files/nsswitch.conf";
  '/etc/pam.d/common-password':
    require => Package["libpam-ldap"],
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    source => '/vagrant/puppet/files/common-password';
  '/etc/pam.d/common-session':
    require => Package["libpam-ldap"],
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0644,
    source  => '/vagrant/puppet/files/common-session';
}
