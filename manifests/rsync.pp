# For backwards compatibility
define lsyncd::rsync (
  $source   = undef,
  $target   = undef,
  $ensure   = present,
  $delete   = undef,
  $delay    = undef,
  $options  = {},
) {
  lsyncd::sync::rsync{$name:
	  source   => $source,
	  target   => $target,
	  ensure   => $ensure,
	  delete   => $delete,
	  delay    => $delay,
	  options  => $options,
  }
}
