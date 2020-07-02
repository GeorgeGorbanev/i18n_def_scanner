# frozen_string_literal: true

RSpec.shared_context 'with dir and load file stub' do
  let(:stub_dir_and_load_file) do
    stub_dir
    stub_file_loading
  end

  let(:stub_dir) do
    allow(Dir)
      .to receive(:[])
      .with(load_path)
      .and_return(dir_mock)
  end

  let(:stub_file_loading) do
    allow(I18nDefScanner::YAML).to receive(:load_file) do |filename|
      load_files[filename] || raise('Dir stubbed with filename without file stub')
    end
  end
end
