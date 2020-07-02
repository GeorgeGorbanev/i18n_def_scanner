# frozen_string_literal: true

module I18nDefScanner
  class CliArguments
    NAMED_ARGS_RE = /--?([^=\s]+)(?:=(\S+))?/.freeze

    attr_accessor :argv_array

    def initialize(argv_array)
      self.argv_array = argv_array
    end

    def to_hash
      { query_path: query_path, load_path: load_path }.compact
    end

    def help?
      named_args.key?('help') || query_path.nil?
    end

    private

    def query_path
      argv_array[0]
    end

    def load_path
      named_args['path']
    end

    def named_args
      @named_args ||= Hash[argv_array.join(' ').scan(NAMED_ARGS_RE)]
    end
  end
end
