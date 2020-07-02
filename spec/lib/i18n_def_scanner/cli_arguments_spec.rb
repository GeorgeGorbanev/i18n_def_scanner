# frozen_string_literal: true

RSpec.describe I18nDefScanner::CliArguments do
  let(:instance) { described_class.new(argv) }
  let(:argv) { [] }

  describe '#to_hash' do
    subject(:result) { instance.to_hash }

    it { expect(result).to eq({}) }

    context 'when query word given' do
      let(:argv) { ['word'] }

      it { expect(result).to eq({ query_path: 'word' }) }

      context 'when load_path given' do
        let(:argv) { super() + ['--path=/Users/username/userpath'] }

        it { expect(result).to eq({ query_path: 'word', load_path: '/Users/username/userpath' }) }
      end
    end
  end

  describe '#help?' do
    subject(:result) { instance.help? }

    it { expect(result).to be(true) }

    context 'when query given' do
      let(:argv) { ['any.query'] }

      it { expect(result).to be(false) }
    end

    context 'when help option given' do
      let(:argv) { ['--help'] }

      it { expect(result).to be(true) }
    end
  end
end
