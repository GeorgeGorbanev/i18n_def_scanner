# frozen_string_literal: true

RSpec.describe 'i18n_def_scanner cli utility spec' do
  describe 'stdout' do
    subject(:executing) { system(command) }

    let(:command) { "bundle exec i18n_def_scanner #{query} --path=#{path}" }
    let(:query) { 'en.key.nested_key' }
    let(:path) { 'spec/dummy_locales/**/*.yml' }

    it do
      expect { executing }
        .to output(a_string_including('spec/dummy_locales/en.yml:3'))
        .to_stdout_from_any_process
    end

    context 'when key not found' do
      let(:query) { 'en.some.not.existing.key' }

      it do
        expect { executing }
          .to output(a_string_including('yml key not found'))
          .to_stdout_from_any_process
      end
    end

    context 'when key has dup in dir' do
      let(:query) { 'en.some.dup.in.dir.key' }

      it do
        expect { executing }
          .to output(a_string_including('spec/dummy_locales/some/en.yml:6'))
          .to_stdout_from_any_process
      end
    end

    shared_examples 'prints help' do
      it do
        expect { executing }
          .to output(a_string_including('Usage: i18n_def_scanner [yml key to find definition] [options]'))
          .to_stdout_from_any_process
      end
    end

    context 'when no query and args given' do
      let(:command) { 'bundle exec i18n_def_scanner' }

      include_examples 'prints help'
    end

    context 'when only help option given' do
      let(:command) { 'bundle exec i18n_def_scanner --help' }

      include_examples 'prints help'
    end

    context 'when query and help option given' do
      let(:command) { 'bundle exec i18n_def_scanner some.yml.key --help' }

      include_examples 'prints help'
    end
  end
end
