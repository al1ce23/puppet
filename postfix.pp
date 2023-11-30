class profile::postfix (
  $myhostname = "${fqdn}",
  $mynetworks = lookup('postfix::iplist'),
  $relayhost = lookup('postfix::hostname'),
  $smtp_user = lookup('postfix::username'),
  $smtp_password = lookup('postfix::password'),
  $message_size_limit = '4000000',
  $default_process_limit = '100',
) {

  package { 'postfix':
    ensure => installed,
  }

  file { '/etc/postfix/main.cf':
    ensure  => present,
    content => template('profile/postfix/main.cf.erb'),
    require => Package['postfix'],
  }

  file { '/etc/postfix/sasl_passwd':
    ensure  => present,
    content => template('profile/postfix/sasl_passwd.erb'),
    mode    => '0600',
    require => Package['postfix'],
  }

  file { '/etc/postfix/sender_canonical':
    ensure  => present,
    content => template('profile/postfix/sender_canonical.erb'),
    mode    => '0600',
    require => Package['postfix'],
  }

  exec { 'postmap_sasl_passwd':
    command     => '/usr/sbin/postmap /etc/postfix/sasl_passwd',
    refreshonly => true,
    subscribe   => File['/etc/postfix/sasl_passwd'],
    require     => Package['postfix'],
  }

  exec { 'postmap_sender_canonical':
    command     => '/usr/sbin/postmap /etc/postfix/sender_canonical',
    refreshonly => true,
    subscribe   => File['/etc/postfix/sender_canonical'],
    require     => Package['postfix'],
  }

  service { 'postfix':
    ensure  => running,
    enable  => true,
    require => [Package['postfix'], File['/etc/postfix/main.cf'], Exec['postmap_sasl_passwd'], Exec['postmap_sender_canonical']],
  }
}
