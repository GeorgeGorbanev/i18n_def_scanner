# frozen_string_literal: true

require 'yaml'

module I18nDefScanner
  module YAML
    def self.load_file(filename)
      File.open(filename, 'r:bom|utf-8') do |f|
        load(f, filename: filename)
      end
    end

    def self.load(yaml, filename: nil)
      result = parse(yaml, filename: filename)
      result = result.to_ruby if result
      result
    end

    def self.parse(yaml, filename: nil)
      parse_stream(yaml, filename: filename) do |node|
        return node
      end
    end

    def self.parse_stream(yaml, filename: nil, &block)
      handler = YAML::Handlers::DocumentStream.new(&block)
      parser = Psych::Parser.new(handler)
      parser.parse(yaml, filename)
    end

    module Handlers
      class DocumentStream < ::YAML::Handlers::DocumentStream
        def start_document(version, tag_directives, implicit)
          n = YAML::Nodes::Document.new(version, tag_directives, implicit)
          push(n)
        end
      end
    end

    module Nodes
      module ToRubyOverride
        def to_ruby
          YAML::Visitors::ToRuby.create.accept(self)
        end
      end

      class Alias < ::YAML::Nodes::Alias
        include ToRubyOverride
      end

      class Document < ::YAML::Nodes::Document
        include ToRubyOverride
      end

      class Mapping < ::YAML::Nodes::Mapping
        include ToRubyOverride
      end

      class Node < ::YAML::Nodes::Node
        include ToRubyOverride
      end

      class Scalar < ::YAML::Nodes::Scalar
        include ToRubyOverride
      end

      class Sequence < ::YAML::Nodes::Sequence
        include ToRubyOverride
      end
    end

    module Visitors
      class ToRuby < ::YAML::Visitors::ToRuby
        def self.create
          class_loader = ::YAML::ClassLoader.new
          scanner = ::YAML::ScalarScanner.new(class_loader)
          YAML::Visitors::ToRuby.new(scanner, class_loader)
        end

        def visit_I18nDefScanner_YAML_Nodes_Scalar(obj)
          visit_Psych_Nodes_Scalar(obj)
        end

        def visit_I18nDefScanner_YAML_Nodes_Sequence(obj)
          visit_Psych_Nodes_Sequence(obj)
        end

        def visit_I18nDefScanner_YAML_Nodes_Mapping(obj)
          visit_Psych_Nodes_Mapping(obj)
        end

        def visit_I18nDefScanner_YAML_Nodes_Document(obj)
          visit_Psych_Nodes_Document(obj)
        end

        def visit_I18nDefScanner_YAML_Nodes_Stream(obj)
          visit_Psych_Nodes_Stream(obj)
        end

        def visit_I18nDefScanner_YAML_Nodes_Alias(obj)
          visit_Psych_Nodes_Alias(obj)
        end

        def revive_hash(hash, obj)
          obj.children.each_slice(2) do |key_node, value_node|
            key = accept(key_node)
            val = accept(value_node)
            val = key_node.start_line + 1 unless val.is_a?(Hash)
            hash[key] = val
          end

          hash
        end
      end
    end
  end
end
