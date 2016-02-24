# puppet-lsyncd
Yet another lsyncd Puppet module. This module allows you to configure lsyncd replication via either Puppet resources or Hiera. Currently only the `default.rsync` process is supported. Feel free to send an issue or a PR if you need to support other processes.

# Usage
To configure a replication via a Puppet resource:
```puppet
lsyncd::rsync { 'myawesomereplication':
  source  => '/tmp/source',
  target  => '/tmp/target',
  options => {
    'archive': true,
  }
```

Or via Hiera:
```yaml
lsyncd::rsync:
  myawesomereplication:
    source: /tmp/source
    target: /tmp/target
    options:
      archive: true
```

# Alternatives
You might prefer [this lsyncd module](https://github.com/spjmurray/puppet-lsyncd) for Ubuntu, or [this one](https://github.com/thias/puppet-lsyncd) for RHEL.
