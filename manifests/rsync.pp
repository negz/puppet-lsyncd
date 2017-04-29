# For backwards compatibility
define lsyncd::rsync (
  $source   = undef,
  $target   = undef,
  $ensure   = present,
  $delete   = true,
  $options  = {},
) {
  lsyncd::sync::rsync{$name:
	  source   => $source,
	  target   => $target,
	  ensure   => $ensure,
	  options  => $options,
  }
}
