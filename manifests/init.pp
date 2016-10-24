class lsyncd (
    $config_dir       = $lsyncd::params::config_dir,
    $config_file      = $lsyncd::params::config_file,
    $settings         = $lsyncd::params::settings,
    $max_user_watches = $lsyncd::params::max_user_watches,
    $package_name     = $lsyncd::params::package_name,
    $service_name     = $lsyncd::params::service_name,
    $rsync            = {},
    $rsyncssh         = {},
) inherits lsyncd::params {

  file { [$config_dir, "${config_dir}/sync.d"]:
    ensure  => 'directory',
    recurse => true,
    purge   => true,
    notify  => Service['lsyncd'],
  }

  file { "${config_dir}/dodir.lua":
    ensure  => present,
    content => file("${module_name}/dodir.lua"),
    mode    => '0644',
    require => File[$config_dir],
    notify  => Service['lsyncd'],
  }

  file { $config_file:
    ensure  => present,
    content => template("${module_name}/lsyncd.conf.lua.erb"),
    mode    => '0644',
    require => File["${config_dir}/dodir.lua"],
    notify  => Service['lsyncd'],
  }

  package { $package_name:
    ensure  => 'latest',
    require => File["${config_file}"],
  }

  service { $service_name:
    ensure    => 'running',
    enable    => true,
    hasstatus => true,
    require   => Package['lsyncd'],
  }

  if $max_user_watches {
    sysctl::value { 'fs.inotify.max_user_watches':
      value   => $max_user_watches,
      notify  => Service['lsyncd']
    }
  }
  
  create_resources(lsyncd::sync::rsync, $rsync)
  create_resources(lsyncd::sync::rsyncssh, $rsyncssh)
}
