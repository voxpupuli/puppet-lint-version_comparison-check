puppet-lint-version_comparison-check
====================================

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-version_comparison-check.svg)](https://github.com/voxpupuli/puppet-lint-version_comparison-check/blob/master/LICENSE)
[![Test](https://github.com/voxpupuli/puppet-lint-version_comparison-check/actions/workflows/test.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-version_comparison-check/actions/workflows/test.yml)
[![Release](https://github.com/voxpupuli/puppet-lint-version_comparison-check/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-version_comparison-check/actions/workflows/release.yml)
[![RubyGem Version](https://img.shields.io/gem/v/puppet-lint-version_comparison-check.svg)](https://rubygems.org/gems/puppet-lint-version_comparison-check)
[![RubyGem Downloads](https://img.shields.io/gem/dt/puppet-lint-version_comparison-check.svg)](https://rubygems.org/gems/puppet-lint-version_comparison-check)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)
[![codecov](https://codecov.io/gh/voxpupuli/puppet-lint-version_comparison-check/branch/master/graph/badge.svg)](https://codecov.io/gh/voxpupuli/puppet-lint-version_comparison-check)

A puppet-lint plugin to check for versions compared as numbers.

## Installing

### From the command line

```shell
$ gem install puppet-lint-version_comparison-check
```

### In a Gemfile

```ruby
gem 'puppet-lint-version_comparison-check', :require => false
```

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

## License

This gem is licensed under the Apache-2 license.

## Release information

To make a new release, please do:
* update the version in the gemspec file
* Install gems with `bundle install --with release --path .vendor`
* generate the changelog with `bundle exec rake changelog`
* Check if the new version matches the closed issues/PRs in the changelog
* Create a PR with it
* After it got merged, push a tag. GitHub actions will do the actual release to rubygems and GitHub Packages
