class profile::motd {
  file { '/etc/profile.d/motd.sh':
    content => template('oye/motd.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }
}
