class lsyncd::params {
  $config_dir  = '/etc/lsyncd'
  $settings = {}
  $max_user_watches = undef
  $service_name = 'lsyncd'
  $package_name = 'lsyncd'
  case $::osfamily {
    'Redhat': {
      $config_file = "/etc/lsyncd.conf"
    }
    'Debian': {
      case $::operatingsystem {
        'Ubuntu': {
          $config_file = "${config_dir}/lsyncd.conf.lua"
				}
		    default: {
		      fail("Unsupported platform: ${module_name} currently doesn't support ${::osfamily} or ${::operatingsystem}")
		    }
		  }
    }
    default: {
      fail("Unsupported platform: ${module_name} currently doesn't support ${::osfamily} or ${::operatingsystem}")
    }
  }
}
