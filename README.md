puppet-lint-version_comparison-check
====================================

[![Build Status](https://img.shields.io/travis/puppet-community/puppet-lint-version_comparison-check.svg)](https://travis-ci.org/puppet-community/puppet-lint-version_comparison-check)
[![Gem Version](https://img.shields.io/gem/v/puppet-lint-version_comparison-check.svg)](https://rubygems.org/gems/puppet-lint-version_comparison-check)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-lint-version_comparison-check.svg)](https://rubygems.org/gems/puppet-lint-version_comparison-check)
[![Coverage Status](https://img.shields.io/coveralls/puppet-community/puppet-lint-version_comparison-check.svg)](https://coveralls.io/r/puppet-community/puppet-lint-version_comparison-check?branch=master)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)

A puppet-lint plugin to check for versions compared as numbers.

## Checks

### Version compared as number

Versions should be managed as strings, and compared using the `versioncmp()` function.

Not doing so will fail with the future parser starting with Puppet 3.7.4.

#### What you have done

```puppet
if $version >= 4 { }
```

#### What you should have done

```puppet
if versioncmp($version, '4') >= 0 { }
```

#### Disabling the check

To disable this check, you can add `--no-version_comparison-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-version_comparison-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_version_comparison')
```

## Transfer Notice

This plugin was originally authored by [Camptocamp](http://www.camptocamp.com).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of Camptocamp.

Previously: https://github.com/camptocamp/puppet-lint-version_comparison-check
