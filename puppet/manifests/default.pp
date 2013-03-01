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

