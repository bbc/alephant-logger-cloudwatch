require "aws-sdk"

module Alephant
  module Logger
    class CloudWatch
      def initialize(opts)
        @cloudwatch = AWS::CloudWatch.new
        @defaults   = process_defaults opts
      end

      def metric(name, opts)
        signature = [name] + opts.values_at(:value, :unit, :dimensions)
        send_metric(*signature)
      end

      private

      attr_reader :cloudwatch, :namespace, :defaults

      def process_defaults(opts)
        preset_defaults.reduce({}) do |acc, (key, value)|
          acc.tap { |h| h[key] = opts.fetch(key, value) }
        end.merge :namespace => opts.fetch(:namespace)
      end

      def preset_defaults
        { :unit => "Count", :value => 1, :dimensions => {} }
      end

      def parse(dimensions)
        dimensions.map do |name, value|
          {
            "name"  => name.to_s,
            "value" => value
          }
        end
      end

      def send_metric(name, value, unit, dimensions)
        Thread.new do
          cloudwatch.put_metric_data(
            :namespace   => defaults[:namespace],
            :metric_data => [{
              :metric_name => name,
              :value       => value || defaults[:value],
              :unit        => unit || defaults[:unit],
              :dimensions  => parse(dimensions || defaults[:dimensions])
            }]
          )
        end
      end
    end
  end
end
