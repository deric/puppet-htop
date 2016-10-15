# == Class htop::params
#
# This class is meant to be called from htop.
# It sets variables according to platform.
#
class htop::params {

  $ensure       = present
  $default_conf = true
  $rcfile       = 'puppet:///modules/htop/htoprc'
  $replace      = true

  case $::osfamily {
    'Debian': {
      $package_name = 'htop'
    }
    'RedHat', 'Amazon': {
      $package_name = 'htop'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
