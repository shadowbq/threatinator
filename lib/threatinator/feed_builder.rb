require 'docile'
require 'threatinator/feed'
require 'threatinator/exceptions'
require 'threatinator/decoders/gzip'
require 'threatinator/fetchers/http'
require 'threatinator/parsers/getline'
require 'threatinator/parsers/csv'
require 'threatinator/parsers/json'
require 'threatinator/parsers/xml'
require 'threatinator/filters/block'
require 'threatinator/filters/whitespace'
require 'threatinator/filters/comments'

module Threatinator
  class FeedBuilder
    def provider(provider_name)
      @provider = provider_name
      self
    end

    def name(name)
      @name = name
      self
    end

    def event_types(event_types=[:notlabeled])
      @event_types ||= event_types
      self
    end

    def fetch_http(url, opts = {})
      opts[:url] = url
      @fetcher_builder = lambda do
        opts_dup = Marshal.load(Marshal.dump(opts))
        Threatinator::Fetchers::Http.new(opts_dup)
      end
      self
    end

    def parse_xml(pattern_string, opts = {}, &block)
      @parser_builder = lambda do
        pattern = Threatinator::Parsers::XML::Pattern.new(pattern_string)
        opts_dup = Marshal.load(Marshal.dump(opts))
        opts_dup[:pattern] = pattern
        Threatinator::Parsers::XML::Parser.new(opts_dup, &block)
      end
      @parser_block = block
      self
    end

    def parse_json(opts = {}, &block)
      @parser_builder = lambda do
        opts_dup = Marshal.load(Marshal.dump(opts))
        Threatinator::Parsers::JSON::Parser.new(opts_dup, &block)
      end
      @parser_block = block
      self
    end

    def parse_eachline(opts = {}, &block)
      @parser_builder = lambda do
        opts_dup = Marshal.load(Marshal.dump(opts))
        Threatinator::Parsers::Getline::Parser.new(opts_dup, &block)
      end
      @parser_block = block
      self
    end

    def parse_csv(opts = {}, &block)
      @parser_builder = lambda do
        opts_dup = Marshal.load(Marshal.dump(opts))
        Threatinator::Parsers::CSV::Parser.new(opts_dup, &block)
      end
      @parser_block = block
      self
    end

    # Specify a block filter for the parser
    def filter(&block)
      @filter_builders ||= []
      @filter_builders << lambda { Threatinator::Filters::Block.new(block) }
      self
    end

    # Filter out whitespace lines. Only works on line-based text.
    def filter_whitespace
      @filter_builders ||= []
      @filter_builders << lambda { Threatinator::Filters::Whitespace.new }
      self
    end

    # Filter out whitespace lines. Only works on line-based text.
    def filter_comments
      @filter_builders ||= []
      @filter_builders << lambda { Threatinator::Filters::Comments.new }
      self
    end

    # Add the Gzip decoder
    def decode_gzip
      decoder_builders << lambda { Threatinator::Decoders::Gzip.new }
      self
    end
    alias_method :extract_gzip, :decode_gzip
    alias_method :gunzip, :decode_gzip

    def decoder_builders
      @decoder_builders ||= []
    end
    private :decoder_builders

    def build
      Feed.new(
        :provider => @provider,
        :name => @name,
        :event_types => @event_types || [:unknown],
        :parser_block => @parser_block,
        :fetcher_builder => @fetcher_builder,
        :parser_builder => @parser_builder,
        :filter_builders => @filter_builders,
        :decoder_builders => decoder_builders
      )
    end

    # Loads the provided file, and generates a builder from it.
    # @param [String] filename The name of the file to read the feed from
    # @raise [FeedFileNotFoundError] if the file is not found
    def self.from_file(filename)
      begin
        filedata = File.read(filename)
      rescue Errno::ENOENT
        raise Threatinator::Exceptions::FeedFileNotFoundError.new(filename)
      end
      from_string(filedata, filename, 0)
    end

    # Generates a builder from a string via eval.
    # @param [String] str The DSL code that specifies the feed.
    # @param [String] filename (nil) Passed to eval.
    # @param [String] lineno (nil) Passed to eval.
    # @raise [FeedFileNotFoundError] if the file is not found
    # @see Kernel#eval for details on filename and lineno
    def self.from_string(str, filename = nil, lineno = nil)
      from_dsl do
        args = [str, binding]
        unless filename.nil?
          args << filename
          unless lineno.nil?
            args << lineno
          end
        end
        eval(*args)
      end
    end

    # Executes the block parameter within DSL scope
    def self.from_dsl(&block)
      Docile.dsl_eval(self.new, &block)
    end
  end
end
