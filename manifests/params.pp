# == Class htop::params
#
# This class is meant to be called from htop.
# It sets variables according to platform.
#
class htop::params {

  $ensure       = present
  $default_conf = true
  $replace      = true

  case $::osfamily {
    'Debian': {
      $package_name = 'htop'
    }
    'RedHat', 'Amazon': {
      $package_name = 'htop'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  # passed to each htop::config instance
  $defaults = {
    'defaults' => {
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
  }

  $users = {
    'root' => {},
  }


}
