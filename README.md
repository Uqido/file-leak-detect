# File::Leak::Detect

This is a simple gem used to detect leaked file. It works only on rspec tests.

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'file-leak-detect'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install file-leak-detect

## Usage

File leak detection is automatically enabled as soon as it's included in Gemfile.
BTW there are two configuration parameters that you can modify as you whish:

```ruby
FileLeakDetect.config do |c|
  c.debug = true
  c.enabled = true
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Uqido/file-leak-detect.
