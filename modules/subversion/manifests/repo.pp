define subversion::repo (
  $repo_name = [],
) {

  vcsrepo { "/var/www/svn/${repo_name}":
    ensure   => present,
    provider => svn,
  }
}
