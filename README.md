# Armoire [![Build Status](https://travis-ci.org/mikespokefire/armoire.png?branch=master)](https://travis-ci.org/mikespokefire/armoire) [![Code Climate](https://codeclimate.com/github/mikespokefire/armoire.png)](https://codeclimate.com/github/mikespokefire/armoire)

A simple configuration tool for your ruby application settings

## Installation

Add this line to your application's Gemfile:

    gem 'armoire'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install armoire

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

You may also call keys with any object that responds to `#to_s` and armoire will work correctly, e.g. `Armoire[:foo]`.

The configuration environment will initially be taken from `ENV['RAILS_ENV']`, then `ENV['RACK_ENV']` and if neither exist then it will fall back to `development`

### Usage in Rails

This gem has a Railtie that automatically loads Armoire as early as it can in the load process, this means that Armoire will be available everywhere in your Rails application.

### Usage in other frameworks

You need to tell Armoire to load your settings as early in the initialisation process as possible by doing:

    Armoire.load! File.expand_path('config/application.yml', File.dirname(__FILE__))

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
