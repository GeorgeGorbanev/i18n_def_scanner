# frozen_string_literal: true

module I18nDefScanner
  class Scanning
    DEFAULT_LOAD_PATH = 'config/locales/**/*.yml'
    NOT_FOUND_MESSAGE = 'yml key not found'

    attr_accessor :load_path, :query_path

    def initialize(load_path: DEFAULT_LOAD_PATH, query_path:)
      self.load_path = load_path
      self.query_path = query_path
    end

    def result
      definition = nil

      files.each do |file_path|
        document_hash = I18nDefScanner::YAML.load_file(file_path)
        string_number = document_hash.dig(*query_keys)
        definition = "#{file_path}:#{string_number}" if string_number
      end

      definition || NOT_FOUND_MESSAGE
    end

    private

    def query_keys
      @query_keys ||= query_path.split('.')
    end

    def files
      Dir[load_path]
    end
  end
end
