# @summary Htop configuration files
#
# @param user
# @param options
# @param replace
# @param defaults
#
define htop::config (
  String  $user     = $name,
  Hash    $options  = {},
  Boolean $replace  = $htop::replace,
  Hash    $defaults = $htop::defaults,
) {
  if ! defined(Class['htop']) {
    fail('You must include the htop base class before using any htop defined resources')
  }

  $config = merge($defaults, $options)

  $homedir = $user ? {
    /root/  => '/',
    default => '/home/',
  }

  case $facts['os']['family'] {
    'RedHat', 'Debian': {
      file { ["${homedir}${user}/.config", "${homedir}${user}/.config/htop",]:
        ensure => directory,
        owner  => $user,
        group  => $user,
        mode   => '0700',
      }

      file { "${homedir}${user}/.config/htop/htoprc":
        ensure  => file,
        owner   => $user,
        group   => $user,
        mode    => '0644',
        replace => $replace,
        content => epp("${module_name}/htoprc.epp", {
            'config' => $config,
        }),
      }
    }
    default: {
      file { "${homedir}${user}/.htoprc":
        ensure  => file,
        owner   => $user,
        group   => $user,
        mode    => '0644',
        replace => $replace,
        content => epp("${module_name}/htoprc.epp", {
            'config' => $config,
        }),
      }
    }
  }
}
