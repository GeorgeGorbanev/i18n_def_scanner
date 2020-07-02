# I18nDefScanner

I18nDefScanner is a CLI tool that helps to find where i18n translations defined. It accepts yaml key as argument and returns file path with line number where translation defined.

## Motivation

When rails-applications grows it becomes harder to maintain order in your translation files. Is it just one file with thousands of lines or hundreds files and directories it will always take time to find definition of translation you need to update if your code editor not configured to do it. So you can find plugin for your code editor or use this gem. Or configure your code editor to use this gem? :)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n_def_scanner', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n_def_scanner

## Usage

All you need is to pass yaml key to executable
``` sh
bundle exec i18n_def_scanner en.my.deeply.nested.yaml.key
```
and it will print file path and definition number of line:
```
config/locales/en.yml:42
```

### Custom locales path

Most of code editors plugins can't analyze rails-application config and consider with custom locales path. As this gem. But this gem has execution options with for locales path:

``` sh
bundle exec i18n_def_scanner en.my.deeply.nested.yaml.key --path=custom_locales_directory/**/*.yml
```

### As a lib

If you need to locate any yaml definitions in your ruby code you can use this gem as lib, it has:

1) Simple public API;
2) No dependencies, using only ruby standard lib;
3) No monkey patching.

Example of usage:

```ruby
require 'i18n_def_scanner'

scanning = I18nDefScanner::Scanning.new(query_path: 'some.key',load_path: 'locales/**/*.yml')
puts scanning.result
# locales/filename.yml:42
```

## Compatibility

Ruby 2.6.3

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/GeorgeGorbanev/i18n_def_scanner.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
