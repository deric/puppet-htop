# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`htop`](#htop): Htop is an interactive process viewer for Unix
* [`htop::install`](#htop--install): Binary package installation

### Defined types

* [`htop::config`](#htop--config): Htop configuration files

### Data types

* [`Htop::Conf`](#Htop--Conf): Single user config
* [`Htop::Screen`](#Htop--Screen): Screen
* [`Htop::Screens`](#Htop--Screens): Screens (tabs) definition
* [`Htop::Users`](#Htop--Users): Configuration for multiple users

## Classes

### <a name="htop"></a>`htop`

Htop is an interactive process viewer for Unix

#### Examples

##### 

```puppet
htop::users:
  john:
    sort_key: 47
```

#### Parameters

The following parameters are available in the `htop` class:

* [`package_name`](#-htop--package_name)
* [`ensure`](#-htop--ensure)
* [`manage_rc`](#-htop--manage_rc)
* [`manage_package`](#-htop--manage_package)
* [`replace`](#-htop--replace)
* [`defaults`](#-htop--defaults)
* [`users`](#-htop--users)

##### <a name="-htop--package_name"></a>`package_name`

Data type: `String`

package name in distribution, usually `htop`

##### <a name="-htop--ensure"></a>`ensure`

Data type: `String`

puppeet will force this package version, possible values
are `present`, `latest` or exact version like `2.0.2`

##### <a name="-htop--manage_rc"></a>`manage_rc`

Data type: `Boolean`

Whether `htoprc` config file should be managed by Puppet at all.

##### <a name="-htop--manage_package"></a>`manage_package`

Data type: `Boolean`

Whether package should be managed by this module

##### <a name="-htop--replace"></a>`replace`

Data type: `Boolean`

Whether to replace a file or symlink that already exists on the local system
but whose content doesn't match what the source or content attribute specifies.
Default: true

##### <a name="-htop--defaults"></a>`defaults`

Data type: `Htop::Conf`

Default configuration for multiple users

##### <a name="-htop--users"></a>`users`

Data type: `Htop::Users`

Configuration for multiple users

### <a name="htop--install"></a>`htop::install`

Binary package installation

#### Parameters

The following parameters are available in the `htop::install` class:

* [`ensure`](#-htop--install--ensure)

##### <a name="-htop--install--ensure"></a>`ensure`

Data type: `String`

package ensure

Default value: `$htop::ensure`

## Defined types

### <a name="htop--config"></a>`htop::config`

Htop configuration files

#### Parameters

The following parameters are available in the `htop::config` defined type:

* [`options`](#-htop--config--options)
* [`replace`](#-htop--config--replace)
* [`defaults`](#-htop--config--defaults)
* [`screens`](#-htop--config--screens)

##### <a name="-htop--config--options"></a>`options`

Data type: `Htop::Conf`

Hash containing key-value pairs

Default value: `{}`

##### <a name="-htop--config--replace"></a>`replace`

Data type: `Boolean`

Whether to replace a file or symlink that already exists on the local system
but whose content doesn't match what the source or content attribute specifies.
Default: true

Default value: `$htop::replace`

##### <a name="-htop--config--defaults"></a>`defaults`

Data type: `Htop::Conf`

Will be overwritten by `options` hash, can be used to provide system-wide defaults

Default value: `$htop::defaults`

##### <a name="-htop--config--screens"></a>`screens`

Data type: `Htop::Screens`

Starting from htop 3.x it's possible to define custom screens

Default value: `undef`

## Data types

### <a name="Htop--Conf"></a>`Htop::Conf`

Single user config

Alias of `Hash[String[1], Variant[String,Integer,Boolean]]`

### <a name="Htop--Screen"></a>`Htop::Screen`

Screen

Alias of

```puppet
Struct[{
  name             => String[1],
  header           => String[1],
  Optional[config] => Htop::Conf,
}]
```

### <a name="Htop--Screens"></a>`Htop::Screens`

Screens (tabs) definition

Alias of `Optional[Array[Htop::Screen]]`

### <a name="Htop--Users"></a>`Htop::Users`

Configuration for multiple users

Alias of

```puppet
Hash[String[1], Struct[{
    Optional[options]  => Htop::Conf,
    Optional[replace]  => Boolean,
    Optional[defaults] => Htop::Conf,
    Optional[screens] => Htop::Screens,
  }]]
```

