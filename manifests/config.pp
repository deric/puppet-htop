# @summary Htop configuration files
#
# @param options
# @param replace
#   Whether to replace a file or symlink that already exists on the local system
#   but whose content doesn't match what the source or content attribute specifies.
#   Default: true
# @param defaults
#
define htop::config (
  Htop::Conf $options  = {},
  Boolean    $replace  = $htop::replace,
  Htop::Conf $defaults = $htop::defaults,
) {
  if ! defined(Class['htop']) {
    fail('You must include the htop base class before using any htop defined resources')
  }
  $user = $title
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
