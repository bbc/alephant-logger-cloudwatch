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

cloudwatch_driver = Alephant::Logger::CloudWatch.new "my_namespace"

logger = Alephant::Logger.setup cloudwatch_driver
logger.metric(:name => "FooBar", :unit => "Count", :value => 1)
```

## Contributing

1. Fork it ( https://github.com/BBC-News/alephant-logger-cloudwatch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
