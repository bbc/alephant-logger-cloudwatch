require "alephant/logger/cloudwatch"

describe Alephant::Logger::CloudWatch do
  subject { described_class.new(:namespace => "namespace") }

  let(:name) { "a" }
  let(:namespace) { "namespace" }

  describe "#metric" do
    let(:opts) do
      {
        :value      => "b",
        :unit       => "c",
        :dimensions => {
          "dimension" => "value"
        }
      }
    end

    let(:metric_data) do
      {
        :metric_name => "a",
        :value       => "b",
        :unit        => "c",
        :dimensions  => [
          {
            "name"  => "dimension",
            "value" => "value"
          }
        ]
      }
    end

    specify do
      ENV['AWS_REGION'] = 'eu-west-1'

      expect_any_instance_of(Aws::CloudWatch::Client)
        .to receive(:put_metric_data)
        .with(
          :namespace   => namespace,
          :metric_data => [metric_data]
        )

      subject.metric(name, opts).join
    end
  end
end
