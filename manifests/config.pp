# == Define htop::config
#
#
define htop::config (
    $user    = $name,
    $rcfile  = $htop::params::rcfile,
    $replace = $htop::params::replace,
  ) {

  if ! defined(Class['htop']) {
    fail('You must include the htop base class before using any htop defined resources')
  }

  $homedir = $user ? {
    /root/  => '/',
    default => '/home/',
  }

  case $::osfamily {
    'RedHat', 'Debian': {
      file { [ "${homedir}${user}/.config", "${homedir}${user}/.config/htop", ]:
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
        source  => $rcfile,
      }
    }
    default: {
      file { "${homedir}${user}/.htoprc":
        ensure  => file,
        owner   => $user,
        group   => $user,
        mode    => '0644',
        replace => $replace,
        source  => $rcfile,
      }
    }
  }
}
