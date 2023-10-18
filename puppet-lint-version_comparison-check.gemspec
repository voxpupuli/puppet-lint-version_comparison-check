Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-version_comparison-check'
  spec.version     = '2.0.0'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-version_comparison-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
    'CHANGELOG.md',
  ]
  spec.summary     = 'A puppet-lint plugin to check for versions compared as numbers.'
  spec.description = <<-EOF
    A puppet-lint plugin to check for versions compared as numbers.
  EOF

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'puppetlabs-puppet-lint', '~> 5.0'
end
