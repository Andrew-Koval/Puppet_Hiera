# === Class: subversion::svn_configs
#
#  Configurations for Subversion Server
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

class subversion::svn_configs (
  $repo_name = [
    'repo1',
    'repo2',
    'repo3',
  ],
) {

  file { '/etc/httpd/conf.d/subversion.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('subversion/subversion.conf.erb'),
    require => Package['mod_dav_svn'],
  }

  file { '/var/log/httpd/subversion.err':
    ensure  => 'present',
    replace => 'no',
    mode    => '0644',
    require => Package['mod_dav_svn'],
  }

  file { '/var/log/httpd/subversion.log':
    ensure  => 'present',
    replace => 'no',
    mode    => '0644',
    require => Package['mod_dav_svn'],
  }
}
