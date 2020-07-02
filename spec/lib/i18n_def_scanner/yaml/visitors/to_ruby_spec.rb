# frozen_string_literal: true

RSpec.describe I18nDefScanner::YAML::Visitors::ToRuby do
  let(:instance) { described_class.create }

  describe '#revive_hash' do
    subject(:result) do
      stub_instance_accept_method
      instance.revive_hash(hash, obj)
    end

    let(:hash) { Hash[some_key: :some_value] }
    let(:obj) { instance_double('I18nDefScanner::YAML::Nodes::Document', children: obj_children) }
    let(:obj_children) { [first_children, second_children, third_children, fourth_children] }
    let(:first_children) { instance_double('I18nDefScanner::YAML::Nodes::Node', start_line: 34) }
    let(:second_children) { instance_double('I18nDefScanner::YAML::Nodes::Node') }
    let(:third_children) { instance_double('I18nDefScanner::YAML::Nodes::Node') }
    let(:fourth_children) { instance_double('I18nDefScanner::YAML::Nodes::Node') }

    let(:stub_instance_accept_method) do
      allow(instance).to receive(:accept) do |arg|
        case arg
        when first_children then :first_hash_key
        when second_children then :first_hash_value
        when third_children then :third_hash_key
        when fourth_children then { hash: :value }
        else raise("Bad #accept stub value: #{arg}")
        end
      end
    end

    it { expect(result).to eq(some_key: :some_value, first_hash_key: 35, third_hash_key: { hash: :value }) }
  end
end
