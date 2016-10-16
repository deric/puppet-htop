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
  $package_name = $::htop::params::package_name,
  $ensure       = $htop::params::ensure,
  $users        = $htop::params::users,
  $config       = $htop::params::config,
  $manage_rc    = true,
) inherits ::htop::params {

  # validate parameters here
  validate_hash($config)
  validate_hash($users)
  validate_bool($manage_rc)

  class { '::htop::install':
    ensure => $ensure,
  } ->
  Class['::htop']

  if $manage_rc {
    create_resources(::htop::config, $users, $config)
  }
}
