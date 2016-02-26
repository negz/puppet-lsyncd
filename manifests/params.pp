class lsyncd::params {
  $config_dir  = '/etc/lsyncd'
  $config_file = 'lsyncd.conf.lua'
  $settings = {
    'logfile'    => '/var/log/lsyncd.log',
    'statusFile' => '/var/log/lsyncd.status',
    'insist'     => true,
  }
  $max_user_watches = undef
}
