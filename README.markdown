# puppet-htop

[![Puppet
Forge](http://img.shields.io/puppetforge/v/deric/htop.svg)](https://forge.puppetlabs.com/deric/htop) [![Build Status](https://travis-ci.org/deric/puppet-htop.png)](https://travis-ci.org/deric/puppet-htop) [![Puppet Forge
Downloads](http://img.shields.io/puppetforge/dt/deric/htop.svg)](https://forge.puppetlabs.com/deric/htop/scores)

Manages `htop` package and its configuration with Hiera support (optional).

## Usage

Basic definition will install `htop` package and create `/root/.config/htop/htoprc` file:
```puppet
class{'::htop':}
```

In most cases you probably want to override just some configuration
```yaml
---
htop::users:
  root:
    options:
      sort_key: '47' # memory
      highlight_base_name: '1'
```

But you can also change global settings (applies to multiple accounts) e.g. via Hiera:
```yaml
---
htop::config:
  defaults:
    sort_key: '47' # sort by memory
    highlight_base_name: '1'
```
you can configure different options for each account:

```yaml
---
htop::users:
  foo:
    options:
      hide_kernel_threads: '0'
  bar:
    options:
      tree_view: '1'
```
user `options` will be merged into global defauls (defined in `htop::config::defaults`).

or directly via puppet code:
```puppet
class{'::htop':
  config => {
    defaults => {
      sort_key => '46',
    }
  }
}
```

## Installation

Preferably using libarian or r10k:
```ruby
mod 'deric-htop'
```

## Requirements

  * Puppet >= 3.3, Puppet 4
  * Ruby 1.9.3 and newer

## Dependencies

  * `puppetlabs-stdlib` - `>= 2.5.0`