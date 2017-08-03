# === Class: roles::server
#
#  Role for deploying of Subversion Server
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

class roles::server {
  include profiles::subversion_server
}

