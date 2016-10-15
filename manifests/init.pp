# Class: htop
# ===========================
#
# Full description of class htop here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class htop (
  $package_name = $::htop::params::package_name,
  $ensure       = $htop::params::ensure,
  $default_conf = $htop::params::default_conf,
  $options      = {},
) inherits ::htop::params {

  # validate parameters here
  validate_hash($options)

  class { '::htop::install':
    ensure => $ensure,
  } ->
  Class['::htop']

  if $default_conf {
    htop::config { 'root':
      options => $options,
    }
  }

}
