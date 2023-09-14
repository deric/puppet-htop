# Class: htop
# ===========================
#
# Htop is an interactive process viewer for Unix
#
# Parameters
# ----------
#
# * `package_name`
#   package name in distribution, usually `htop`
#
# * `ensure`
#   puppeet will force this package version, possible values
#   are `present`, `latest` or exact version like `2.0.2`
#
# * `manage_rc`
#   Whether `htoprc` config file should be managed by Puppet at all.
#
class htop (
  String  $package_name = $htop::params::package_name,
  String  $ensure       = $htop::params::ensure,
  Hash    $users        = $htop::params::users,
  Hash    $config       = $htop::params::config,
  Boolean $manage_rc    = true,
) inherits htop::params {
  class { 'htop::install':
    ensure  => $ensure,
    require => Class['htop'],
  }

  if $manage_rc {
    # require at least stdlib 2.5.0
    # ::htop::config will break some puppet versions
    # `create_resources` works on ruby 1.9.3 but not `ensure_resources`
    create_resources(htop::config, $users, $config)
  }
}
