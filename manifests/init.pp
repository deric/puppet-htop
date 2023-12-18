# @summary Htop is an interactive process viewer for Unix
#
# @param package_name
#   package name in distribution, usually `htop`
#
# @param ensure
#   puppeet will force this package version, possible values
#   are `present`, `latest` or exact version like `2.0.2`
#
# @param manage_rc
#   Whether `htoprc` config file should be managed by Puppet at all.
# @param replace
#   Whether to replace a file or symlink that already exists on the local system
#   but whose content doesn't match what the source or content attribute specifies.
#   Default: true
# @param defaults
#  Default configuration for multiple users
# @param users
#   Configuration for multiple users
#
# @example
#  htop::users:
#    john:
#      sort_key: 47
#
class htop (
  String      $package_name,
  String      $ensure,
  Boolean     $replace,
  Boolean     $manage_rc,
  Htop::Users $users,
  Htop::Conf  $defaults,
) {
  contain htop::install

  if $manage_rc {
    create_resources(htop::config, $users)
  }
}
