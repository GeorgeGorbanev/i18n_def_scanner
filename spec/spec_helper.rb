# frozen_string_literal: true

require 'bundler/setup'
require 'i18n_def_scanner'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with(:rspec) { |c| c.syntax = :expect }

  support_path = File.join('spec', 'support/**/*.rb')
  Dir[support_path].each do |support_file|
    require("./#{support_file}")
  end
end
