require 'bundler/setup'
require 'rspec'
require 'file/leak/detect'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end
end

FileLeakDetect.config do |c|
  c.debug = true
  c.enabled = true
end
