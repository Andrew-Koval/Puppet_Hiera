# === Class: subversion::svn
#
# Installation of Subversion Server
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

class subversion::svn {

  package { 'mod_dav_svn':
    ensure => 'installed',
    before => Package['subversion'],
  }

  package { 'subversion':
    ensure  => 'installed',
    require => Package['mod_dav_svn'],
  }

  file { '/var/www/svn':
    ensure => 'directory',
    owner  => 'apache',
    group  => 'apache',
    mode   => '0755',
    require => Package['mod_dav_svn'],
  }
}
