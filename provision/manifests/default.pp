#
# site.pp - defines defaults for vagrant provisioning
#

# use run stages for minor vagrant environment fixes
#stage { 'pre': before    => Stage['main'] }
#class { 'mirrors': stage => 'pre' }
#class { 'vagrant': stage => 'pre' }

class { 'puppet':}
#class { 'hosts':
#  $hosts => { puppet => '33.33.33.10',}
#}



if $hostname == 'puppet' {
  class { 'puppet::server': }
  host { 'www-centos':
          ip           => '33.33.33.11',
          host_aliases => [ 'www-centos.dev.inwork.ch','www-centos' ],
          comment     => 'Add by puppet',
  }
  host { 'www-ubuntu':
          ip           => '33.33.33.12',
          host_aliases => [ 'www-ubuntu.dev.inwork.ch','www-ubuntu' ],
          comment     => 'Add by puppet',
  }
}else {
  host { 'puppet':
          ip           => '33.33.33.10',
          host_aliases => [ 'puppet.dev.inwork.ch','puppet' ],
          comment     => 'Add by puppet',
  }
}