# puppet-htop

Manages `htop` package and its configuration

## Usage

```puppet
class{'::htop':}
```

Accepts parameter settings e.g. via Hiera:
```yaml
---
htop::options:
  sort_key: '47' # memory
  highlight_base_name: '1'
```

or directly via puppet code:
```puppet
class{'::htop':
  options => {
    sort_key => '46',
  }
}
```

## TODO

 * configure options per user
