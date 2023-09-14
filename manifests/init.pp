# @summary Htop is an interactive process viewer for Unix
#
# Parameters
# ----------
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
# @param config
# @param users
#
class htop (
  String  $package_name,
  String  $ensure,
  Boolean $replace,
  Boolean $manage_rc,
  Hash    $users,
  Hash    $config,
) {
  contain htop::install

  if $manage_rc {
    create_resources(htop::config, $users, $config)
  }
}
