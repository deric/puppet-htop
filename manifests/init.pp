# Class: htop
# ===========================
#
# Htop is an interactive process viewer for Unix
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
# @param config
# @param users
#
class htop (
  String  $package_name,
  String  $ensure,
  Hash    $users = {},
  Hash    $config = {},
  Boolean $manage_rc    = true,
) {
  contain htop::install

  if $manage_rc {
    # require at least stdlib 2.5.0
    # ::htop::config will break some puppet versions
    # `create_resources` works on ruby 1.9.3 but not `ensure_resources`
    create_resources('htop::config', $users, $config)
  }
}
