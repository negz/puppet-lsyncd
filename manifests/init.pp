class lsyncd (
    $config_dir  = $lsyncd::params::config_dir,
    $config_file = $lsyncd::params::config_file,
    $settings    = $lsyncd::params::settings,
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

  create_resources(lsyncd::rsync, hiera_hash('lsyncd::rsync', {}))
}
