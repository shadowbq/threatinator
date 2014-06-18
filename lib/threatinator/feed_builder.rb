require 'threatinator/feed'
require 'threatinator/fetchers/http'
require 'threatinator/parsers/getline'
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

    def fetch_http(url, opts = {})
      opts[:url] = url
      @fetcher_class = Threatinator::Fetchers::Http
      @fetcher_opts = opts
      self
    end

    def parse_eachline(opts = {}, &block)
      @parser_class = Threatinator::Parsers::Getline
      @parser_opts = opts
      @parser_block = block
      self
    end

    # Specify a block filter for the parser
    def filter(&block)
      @filters ||= []
      @filters << Threatinator::Filters::Block.new(block)
      self
    end

    # Filter out whitespace lines. Only works on line-based text.
    def filter_whitespace
      @filters ||= []
      @filters << Threatinator::Filters::Whitespace.new
      self
    end
    
    # Filter out whitespace lines. Only works on line-based text.
    def filter_comments
      @filters ||= []
      @filters << Threatinator::Filters::Comments.new
      self
    end

    def build
      Feed.new(
        :provider => @provider, 
        :name => @name,
        :fetcher_class => @fetcher_class,
        :fetcher_opts => @fetcher_opts,
        :parser_class => @parser_class,
        :parser_opts => @parser_opts,
        :parser_block => @parser_block,
        :filters => @filters || []
      )
    end
  end
end
