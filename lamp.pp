node 'command' {

  include lamp

  file { 'motd':
    path => '/etc/motd',
    ensure => present,
    content => 'Puppet MOTD'
  }
}

class lamp {
package { 'apache2' :
  ensure => present,
}
service { 'apache2' :
  ensure => running,
  enable => true,
  require => Package['apache2'],
}
package { 'mysql-server' :
  ensure => present,
}
service { 'mysql' :
  ensure => running,
  enable => true,
}
package { 'php' :
  ensure => present,
}
package { 'php-mysql' :
  ensure => present,
  require => Package['mysql-server'] 
}
file { '/var/www/html/info.php':
  ensure => file,
  content => '<?php phpinfo(); ?>',
  require => Package['apache2'],
}
}
