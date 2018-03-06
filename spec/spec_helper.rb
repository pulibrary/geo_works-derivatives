# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'
ENV['RAILS_ENV'] = 'test'
require 'simplecov'
require 'coveralls'
require 'fileutils'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
)
SimpleCov.start do
  add_filter 'spec'
  add_filter 'lib/geo_works/derivatives/config'
end

require "bundler/setup"
require "geo_works/derivatives"

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

# Create local tmp directory to allow for easy inspection of derivative outputs.
tmp_directory_path = File.join(Pathname.new(Dir.pwd), "tmp")
Dir.mkdir(tmp_directory_path) unless Dir.exist?(tmp_directory_path)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
