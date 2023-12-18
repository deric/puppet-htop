# @summary Binary package installation
#
# @param ensure
#   package ensure
#
class htop::install (
  String $ensure = $htop::ensure,
) {
  package { $htop::package_name:
    ensure => $ensure,
  }
}
