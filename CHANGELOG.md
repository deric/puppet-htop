# Changelog

All notable changes to this project will be documented in this file.

## Release 1.0.0 [2023-12-18]

- Support `htop` 3.x screens
- **BC** removed Hash param `htop::config`, use `htop::defaults` instead
- Enforce hash structure
- Defaults moved to specific distribution
- Packages installed using `ensure_packages()`
- Add param `manage_package`
- Template converted to epp
- Deep merge configs by default

## Release 0.4.0

- Use hierarical facts
- Removed params class
- Puppet 8 and stdlib 9 compatibility

## Release 0.3.0

- Use types

## Release 0.2.0

**Bugfixes**
Using Puppet Types, removed deprecated `validate_*` functions

**Known Issues**
