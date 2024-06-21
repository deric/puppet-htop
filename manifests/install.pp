# @summary Binary package installation
#
# @param ensure
#   package ensure
#
class htop::install (
  String $ensure = $htop::ensure,
) {
  if $htop::manage_package {
    stdlib::ensure_packages([$htop::package_name], { 'ensure' => $ensure })
  }
}
