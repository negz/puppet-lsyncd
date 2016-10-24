#For BC
define lsyncd::rsync (
  $source   = undef,
  $target   = undef,
  $ensure   = present,
  $options  = {},
) {
  lsyncd::sync::rsync{$name:
	  source   => $source,
	  target   => $target,
	  ensure   => $ensure,
	  options  => $options,
  }
}