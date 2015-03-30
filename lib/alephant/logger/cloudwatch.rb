require "aws-sdk"

module Alephant
  module Logger
    class CloudWatch
      def initialize(opts)
        @opts = opts
        @cloudwatch = AWS::CloudWatch.new
      end

      def metric(opts)
        send_metric(*opts.values_at(:name, :value, :unit, :dimensions))
      end

      private

      attr_reader :cloudwatch

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
            :namespace   => @opts[:namespace],
            :metric_data => [{
              :metric_name => name,
              :value       => value || @opts[:value],
              :unit        => unit || @opts[:unit] || "None",
              :dimensions  => parse(dimensions || @opts[:dimensions] || {})
            }]
          )
        end
      end
    end
  end
end
