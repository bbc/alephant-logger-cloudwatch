require "alephant/logger/cloudwatch"

describe Alephant::Logger::CloudWatch do
  subject { described_class.new("namespace") }

  let(:namespace) { "namespace" }

  describe "#metric" do
    let(:opts) do
      {
        :name       => "a",
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
            :name  => "dimension",
            :value => "value"
          }
        ]
      }
    end

    specify do
      expect_any_instance_of(AWS::CloudWatch)
        .to receive(:put_metric_data)
        .with(
          :namespace   => namespace,
          :metric_data => [metric_data]
        )

      subject.metric(opts).join
    end
  end
end
