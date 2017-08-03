# === Class: httpd
#
#  Apache HTTPD Web Server v.2.2.15 for CentOS 6
#
# === Parameters
#
# None
#
# === Variables
#
# None
#
# === Examples
#
# None
#
# === Authors
#
# Andriy Koval <akova@softserveinc.com>
#
# === Copyright
#
# Copyright 2017 Andriy Koval
#

class httpd (
  $ssl                  = false,
  # Options for httpd.conf
  # The original default is 'OS', but 'Prod' makes more sense to hide version
  $servertokens         = 'OS',
  # timeout is a reserved puppet variable
  $timeout_seconds      = '60',
  $keepalive            = 'Off',
  $maxkeepaliverequests = '100',
  $keepalivetimeout     = '15',
  $startservers         = '4',
  $minspareservers      = '2',
  $maxspareservers      = '8',
  $serverlimit          = '256',
  $maxclients           = '256',
  $maxrequestsperchild  = '4000',
  $minsparethreads      = '25',
  $maxsparethreads      = '75',
  $threadsperchild      = '32',
  $listen               = [ '80' ],
  $namevirtualhost      = [],
  $extendedstatus       = 'Off',
  $user                 = 'apache',
  $group                = 'apache',
  $serveradmin          = 'root@localhost',
  $servername           = undef,
  $usecanonicalname     = 'Off',
  $documentroot         = '/var/www/html',
  $serversignature      = 'On',
  # Other
  $httpd_version        = 'latest',
  $service_restart      = '/sbin/service httpd reload',
) {
  package { 'httpd':
    ensure => $version,
  }

  file { '/etc/httpd/conf/httpd.conf':
    require => Package['httpd'],
    content => template('httpd/httpd.conf.erb'),
    notify  => Service['httpd'],
  }

  service { 'httpd':
    ensure    => running,
    enable    => true,
    restart   => $service_restart,
    hasstatus => true,
    require   => Package['httpd'],
  }
  if $ssl {
    package { 'mod_ssl':
      ensure => installed,
      notify => Service['httpd'],
    }
    httpd::file { 'ssl.conf':
      source  => "puppet:///modules/httpd/ssl.conf",
      require => Package['mod_ssl'],
    }
  }
}
