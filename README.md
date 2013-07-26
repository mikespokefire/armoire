# Armoire [![Build Status](https://travis-ci.org/mikespokefire/armoire.png?branch=master)](https://travis-ci.org/mikespokefire/armoire)

A simple configuration tool for your ruby application settings

## Installation

Add this line to your application's Gemfile:

    gem 'configuration'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install configuration

## Usage

Armoire should be simple. Simply create a yaml file in `config/application.yml` with the following:

    development:
      foo: "bar"
      baz: 42
      nested_options:
        nested_foo: "nested_bar"
        nested_baz: 99.999
      boolean_value: true
      parsed_things: <% "something_in_erb" %>

    test:
      foo: "bar"
      baz: 42
      nested_options:
        nested_foo: "nested bar"
        nested_baz: 99.999
      boolean_value: true
      parsed_things: <% "something_in_erb" %>

Simply call `Armoire["foo"]` to get `"bar"` or `Armoire["nested_options"]["nested_foo"]` to get `"nested_bar"`. Any ERB will be parsed when the config file is loaded. If a configuration option is missing, it will throw an `Armoire::ConfigSettingMissing` exception.

The configuration environment will initially be taken from `ENV['RAILS_ENV']`, then `ENV['RACK_ENV']` and if neither exist then it will fall back to `development`


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
