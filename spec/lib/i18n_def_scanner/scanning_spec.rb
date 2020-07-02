# frozen_string_literal: true

RSpec.describe I18nDefScanner::Scanning do
  let(:instance) { described_class.new(args) }
  let(:args) { Hash[load_path: load_path, query_path: query_path] }
  let(:load_path) { '../sample_locales/**/*.yml' }
  let(:query_path) { 'en.some.nested_attribute' }

  describe '#query_path' do
    subject(:result) { instance.query_path }

    it { expect(result).to eq('en.some.nested_attribute') }
  end

  describe '#load_path' do
    subject(:result) { instance.load_path }

    it { expect(result).to eq('../sample_locales/**/*.yml') }

    context 'when load_path arg not given' do
      let(:args) { super().reject { |key| key == :load_path } }

      it { expect(result).to eq('config/locales/**/*.yml') }
    end
  end

  describe '#result' do
    subject(:result) do
      stub_dir_and_load_file
      instance.result
    end

    include_context 'with dir and load file stub'

    let(:dir_mock) { ['some/file/path.yml'] }
    let(:load_files) { Hash['some/file/path.yml' => { 'en' => { 'some' => { 'nested_attribute' => 42 } } }] }

    it { expect(result).to eq('some/file/path.yml:42') }

    context 'when key not found' do
      let(:load_files) { Hash['some/file/path.yml' => {}] }

      it { expect(result).to eq('yml key not found') }
    end

    context 'when key defined twice' do
      let(:dir_mock) { ['some/file/path.yml', 'some/file/path-two.yml'] }

      let(:load_files) do
        { 'some/file/path.yml' => { 'en' => { 'some' => { 'nested_attribute' => 42 } } },
          'some/file/path-two.yml' => { 'en' => { 'some' => { 'nested_attribute' => 24 } } } }
      end

      it { expect(result).to eq('some/file/path-two.yml:24') }
    end
  end
end
