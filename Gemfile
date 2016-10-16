source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 3.8.0'
  gem "rspec", '< 3.2.0'
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
  gem "rspec-puppet-facts"
  gem 'rubocop', '0.33.0'
  gem 'simplecov', '>= 0.11.0'
  gem 'simplecov-console'
  if RUBY_VERSION =~ /^2\.0\./ or RUBY_VERSION =~ /^2\.1\./
    gem 'ruby_dep', '< 1.4.0'
  end
  gem 'listen', '< 3.0'
  gem 'librarian-puppet' , '>=2.0'
  if RUBY_VERSION =~ /^1\.9\./ or RUBY_VERSION =~ /^1\.8\./
    gem 'json', '< 2.0' # newer versions requires at least ruby 2.0
    gem 'json_pure', '< 2.0.0'
    gem 'fog-google', '< 0.1.1'
    gem 'google-api-client', '< 0.9'
  end

  gem "puppet-lint-absolute_classname-check"
  gem "puppet-lint-leading_zero-check"
  gem "puppet-lint-trailing_comma-check"
  gem "puppet-lint-version_comparison-check"
  gem "puppet-lint-classes_and_types_beginning_with_digits-check"
  gem "puppet-lint-unquoted_string-check"
  gem 'puppet-lint-resource_reference_syntax'
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "puppet-blacksmith"
  gem "guard-rake"
  if RUBY_VERSION =~ /^1\.9\./ or RUBY_VERSION =~ /^1\.8\./
    gem 'net-http-persistent', '< 3.0'
  end
end

group :system_tests do
  gem "beaker", '< 3.0'
  gem "beaker-rspec"
  gem "beaker-puppet_install_helper"
end
