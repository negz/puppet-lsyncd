class lsyncd (
    $config_dir       = $lsyncd::params::config_dir,
    $config_file      = $lsyncd::params::config_file,
    $settings         = $lsyncd::params::settings,
    $max_user_watches = $lsyncd::params::max_user_watches,
) inherits lsyncd::params {

  file { [$config_dir, "${config_dir}/sync.d"]:
    ensure => 'directory',
  }

  file { "${config_dir}/dodir.lua":
    ensure  => present,
    content => file("${module_name}/dodir.lua"),
    mode    => '0644',
    require => File[$config_dir],
    notify  => Service['lsyncd'],
  }

  file { "${config_dir}/${config_file}":
    ensure  => present,
    content => template("${module_name}/lsyncd.conf.lua.erb"),
    mode    => '0644',
    require => File["${config_dir}/dodir.lua"],
    notify  => Service['lsyncd'],
  }

  package { 'lsyncd':
    ensure  => 'latest',
    require => File["${config_dir}/${config_file}"],
  }

  service { 'lsyncd':
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

  create_resources(lsyncd::rsync, hiera_hash('lsyncd::rsync', {}))
}
