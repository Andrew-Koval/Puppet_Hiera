# === Class: subversion::svn_admin
#
#  Creation of first subversion user
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

class subversion::svn_admin (
  $svn_admin	  = [],
  $admin_password = [],
) {

  htpasswd { "$svn_admin":
    cryptpasswd => "$admin_password",  # encrypted password
    target	=> '/etc/svn-auth-conf',
    require     => File['/etc/svn-auth-conf'],
  }

  file { '/etc/svn-auth-conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
