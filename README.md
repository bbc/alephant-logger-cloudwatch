# Alephant::Logger::Cloudwatch

AWS CloudWatch driver for the [alephant-logger](https://github.com/BBC-News/alephant-logger) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alephant-logger-cloudwatch'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install alephant-logger-cloudwatch
```

## Usage

```ruby
require "alephant/logger"
require "alephant/logger/cloudwatch"

cloudwatch_driver = Alephant::Logger::CloudWatch.new(:namespace => "my_namespace")

logger = Alephant::Logger.setup cloudwatch_driver
logger.metric("FooBar", :unit => "Count", :value => 1)
```

You can also prefill in default values when creating a new instance of the logger (and still override individual settings for each logger call):

```ruby
require "alephant/logger"
require "alephant/logger/cloudwatch"

# Define defaults
cloudwatch_driver = Alephant::Logger::CloudWatch.new(
  :namespace  => "my_namespace",
  :unit       => "Count",
  :value      => 1,
  :dimensions => { :foo => "bar" }
)

logger = Alephant::Logger.setup cloudwatch_driver

# Override specific settings for this logger call
logger.metric("FooBar", :unit => "Percent", :value => 2)

# Use predefined defaults
logger.metric("BazQux")
```

## Contributing

1. Fork it ( https://github.com/BBC-News/alephant-logger-cloudwatch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
