# puppet-htop

Manages `htop` package and its configuration with Hiera support (optional).

## Usage

Basic definition will install `htop` package and create `/root/.config/htop/htoprc` file:
```puppet
class{'::htop':}
```

Accepts global settings (for multiple accounts) e.g. via Hiera:
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
htop::config:
  users:
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
```
mod 'deric-htop'
```