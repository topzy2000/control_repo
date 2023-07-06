class motd {
  file { '/etc/profile.d/motd.sh':
    content => template('iovation/motd/iovation_motd.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }
}
