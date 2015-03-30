require "aws-sdk"

module Alephant
  module Logger
    class CloudWatch
      def initialize(opts)
        @cloudwatch = AWS::CloudWatch.new

        preset_defaults = { :unit => "Count", :value => 1, :dimensions => {} }
        preset_defaults.each do |key, value|
          @defaults[key] = opts.fetch(key) { value }
        end
      end

      def metric(opts)
        send_metric(*opts.values_at(:name, :value, :unit, :dimensions))
      end

      private

      attr_reader :cloudwatch, :defaults

      def parse(dimensions)
        dimensions.map do |name, value|
          {
            :name  => name,
            :value => value
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
