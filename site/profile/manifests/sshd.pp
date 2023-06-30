class profile::sshd {
   package { 'openssh-server':
    ensure => present
   }
   case $::os[release][major] {
    '6': {
      sshd_config { 'Ciphers':
        ensure => present,
        value  => [ 'aes256-ctr', 'aes192-ctr', 'aes128-ctr', ],
        notify => Service['sshd'],
      }
      sshd_config { 'MACs':
        ensure => present,
        value  => [ 'hmac-sha2-512', 'hmac-sha2-256', ],
        notify => Service['sshd'],
      }
      sshd_config { 'KexAlgorithms':
        ensure => present,
        value  => [ 'diffie-hellman-group-exchange-sha256', ],
        notify => Service['sshd'],
      }
    }
    '7': {
      sshd_config { 'Ciphers':
        ensure => present,
        value  => [ 'chacha20-poly1305@openssh.com',
        'aes256-gcm@openssh.com',
        'aes128-gcm@openssh.com',
        'aes256-ctr',
        'aes192-ctr',
        'aes128-ctr', ],
        notify => Service['sshd'],
      }
      sshd_config { 'MACs':
        ensure => present,
        value  => [ 'hmac-sha2-512-etm@openssh.com',
        'hmac-sha2-256-etm@openssh.com',
        'umac-128-etm@openssh.com',
        'hmac-sha2-512',
        'hmac-sha2-256',
        'umac-128@openssh.com', ],
        notify => Service['sshd'],
      }
      sshd_config { 'KexAlgorithms':
        ensure => present,
        value  => [ 'curve25519-sha256@libssh.org',
        'ecdh-sha2-nistp521',
        'ecdh-sha2-nistp384',
        'ecdh-sha2-nistp256',
        'diffie-hellman-group-exchange-sha256', ],
        notify => Service['sshd'],
      }
    }
    default: {
      sshd_config { 'Ciphers':
        ensure => present,
        value  => [ 'chacha20-poly1305@openssh.com',
        'aes256-gcm@openssh.com',
        'aes128-gcm@openssh.com',
        'aes256-ctr',
        'aes192-ctr',
        'aes128-ctr', ],
        notify => Service['sshd'],
      }
      sshd_config { 'MACs':
        ensure => present,
        value  => [ 'hmac-sha2-512-etm@openssh.com',
        'hmac-sha2-256-etm@openssh.com',
        'umac-128-etm@openssh.com',
        'hmac-sha2-512',
        'hmac-sha2-256',
        'umac-128@openssh.com', ],
        notify => Service['sshd'],
      }
      sshd_config { 'KexAlgorithms':
        ensure => present,
        value  => [ 'curve25519-sha256@libssh.org',
        'ecdh-sha2-nistp521',
        'ecdh-sha2-nistp384',
        'ecdh-sha2-nistp256',
        'diffie-hellman-group-exchange-sha256', ],
        notify => Service['sshd'],
      }
      file { '/etc/sysconfig/sshd':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0640',
        source => 'puppet:///sshd',
        notify => Service['sshd'],
      }
    }
  }
  service { 'sshd':
    ensure     => 'running',
    require    => Package['openssh-server'],
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
