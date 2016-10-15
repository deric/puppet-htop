# == Class htop::install
#
# This class is called from htop for install.
#
class htop::install(
    $ensure,
  ) {

  package { $::htop::package_name:
    ensure => $ensure,
  }
}
