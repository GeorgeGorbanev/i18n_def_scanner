# frozen_string_literal: true

RSpec.describe I18nDefScanner do
  describe '::VERSION' do
    subject(:result) { described_class::VERSION }

    it { expect(result).not_to be(nil) }
  end
end
