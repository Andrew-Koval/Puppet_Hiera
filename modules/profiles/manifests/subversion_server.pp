# === Class: profiles::subversion_server
#
#  Profile for deploying of Subversion Server
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

class profiles::subversion_server (
  $listen         = hiera('httpd::listen'),
  $svn_admin      = hiera('subversion::svn_admin::svn_admin'),
  $admin_password = hiera('subversion::svn_admin::admin_password'),
  $svn_user       = hiera('subversion::svn_users::svn_user'),
  $svn_password   = hiera('subversion::svn_users::svn_password'),
){

  class { 'subversion::svn':
    before => Class['subversion::svn_configs'],
  }

  class { 'subversion::svn_configs':
    require => Class['subversion::svn'],
  }

  subversion::repo { 'repo1':
    repo_name => ['repo1'],
    require   => Class['subversion::svn'],
  }

  subversion::repo { 'repo2':
    repo_name => ['repo2'],
    require   => Class['subversion::svn'],
  }

  subversion::repo { 'repo3':
    repo_name => ['repo3'],
    require   => Class['subversion::svn'],
  }

  class { 'subversion::svn_admin':
    svn_admin      => $svn_admin,
    admin_password => $admin_password,
    require => Class['subversion::svn_configs'],
  }

  subversion::svn_users { 'user1':
    svn_user      => $svn_user,
    user_password => $svn_password,
    require       => Class['subversion::svn_admin'],
  }

  subversion::svn_users { 'user2':
    svn_user      => $svn_user,
    user_password => $svn_password,
    require       => Class['subversion::svn_admin'],
  }

  subversion::svn_users { 'user3':
    svn_user      => $svn_user,
    user_password => $svn_password,
    require       => Class['subversion::svn_admin'],
  }

  class { 'https':
    require => Class['subversion::svn_admin'],
    before  => Class['httpd'],
  }

  class { 'httpd':
    listen  => $listen,
    require => Class['https'],
  }
}
