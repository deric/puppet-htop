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
class htop (
  $package_name = $::htop::params::package_name,
  $ensure       = $htop::params::ensure,
  $default_conf = $htop::params::default_conf,
  $options      = {},
  $defaults     = $htop::params::defaults,
) inherits ::htop::params {

  # validate parameters here
  validate_hash($options)
  validate_hash($defaults)

  class { '::htop::install':
    ensure => $ensure,
  } ->
  Class['::htop']

  if $default_conf {
    htop::config { 'root':
      options  => $options,
      defaults => $defaults,
    }
  }

}
