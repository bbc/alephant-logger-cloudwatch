require "aws-sdk"

module Alephant
  module Logger
    class CloudWatch
      def initialize(namespace, unit = "Count", value = 1, dimensions = {})
        @namespace  = namespace
        @unit       = unit
        @value      = value
        @dimensions = dimensions
        @cloudwatch = AWS::CloudWatch.new
      end

      def metric(opts)
        send_metric(*opts.values_at(:name, :value, :unit, :dimensions))
      end

      private

      attr_reader :cloudwatch, :namespace

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
            :namespace   => namespace,
            :metric_data => [{
              :metric_name => name,
              :value       => value || @value,
              :unit        => unit || @unit || "None",
              :dimensions  => parse(dimensions || @dimensions || {})
            }]
          )
        end
      end
    end
  end
end
