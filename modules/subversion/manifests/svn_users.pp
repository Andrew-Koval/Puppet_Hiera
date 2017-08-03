define subversion::svn_users (
  $svn_user  	 = [],
  $user_password = [],
) {

  htpasswd { "$svn_user":
    username    => "$svn_user",
    cryptpasswd => "$user_password",  # encrypted password
    target	=> '/etc/svn-auth-conf',
  }
}
