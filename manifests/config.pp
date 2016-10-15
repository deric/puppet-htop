# == Define htop::config
#
#
define htop::config (
    $user    = $name,
    $options = {},
    $replace = $htop::params::replace,
  ) {

  if ! defined(Class['htop']) {
    fail('You must include the htop base class before using any htop defined resources')
  }

  $defaults = {
    'fields' => '0 48 17 18 38 39 40 2 46 47 49 1',
    'sort_key' => '46',
    'sort_direction' => '1',
    'hide_threads' => '0',
    'hide_kernel_threads' => '1',
    'hide_userland_threads' => '1',
    'shadow_other_users' => '0',
    'show_thread_names' => '0',
    'highlight_base_name' => '0',
    'highlight_megabytes' => '1',
    'highlight_threads' => '0',
    'tree_view' => '0',
    'header_margin' => '1',
    'detailed_cpu_time' => '0',
    'cpu_count_from_zero' => '0',
    'update_process_names' => '0',
    'account_guest_in_cpu_meter' => '0',
    'color_scheme' => '0',
    'delay' => '15',
    'left_meters' => 'LeftCPUs Memory Swap',
    'left_meter_modes' => '1 1 1',
    'right_meters' => 'RightCPUs Tasks LoadAverage Uptime',
    'right_meter_modes' => '1 2 2 2',
  }

  $config = merge($defaults, $options)

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
        content => template('htop/htoprc.erb'),
      }
    }
    default: {
      file { "${homedir}${user}/.htoprc":
        ensure  => file,
        owner   => $user,
        group   => $user,
        mode    => '0644',
        replace => $replace,
        content => template('htop/htoprc.erb'),
      }
    }
  }
}
