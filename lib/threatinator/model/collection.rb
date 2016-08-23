require 'threatinator/exceptions'
require 'set'

module Threatinator
  module Model
    class Collection
      def initialize(values = [])
        @collection = Set.new
        values.each do |v|
          self << v
        end
      end

      def valid_member?(v)
        #:nocov:
        raise NotImplementedError, "#valid_member? not implemented"
        #:nocov:
      end

      def <<(v)
        unless valid_member?(v)
          raise Threatinator::Exceptions::InvalidAttributeError, "Invalid member: #{v.class} '#{v.inspect}'"
        end
        @collection << v
      end

      def include?(member)
        @collection.include?(member)
      end
      alias_method :member?, :include?

      # @return [Boolean] true if empty, false otherwise
      def empty?
        @collection.empty?
      end

      def collect!
        block_given? or return enum_for(__method__)
        @collection.replace(@collection.class.new(@collection) { |o| yield(o) })
      end

      def delete(o)
        @collection.delete(o)
      end

      def delete?(o)
        @collection.delete?(o)
      end

      # @return [Integer] the number of members in the collection
      def count
        @collection.count
      end
      alias_method :size, :count
      alias_method :length, :count

      def to_ary
        @collection.to_a
      end
      alias_method :to_a, :to_ary

      # [31] pry(#<Threatinator::Plugins::Output::Json>)> event.urls.each{ |uri| p uri.to_s }
      # "http://teamadrenaline.com/js/t1.exe"
      # =>  [#<Addressable::URI:0x114c6ec URI:http://teamadrenaline.com/js/t1.exe>]
      def each
        return to_enum(:each) unless block_given?
        @collection.each { |v| yield v }
      end

      def list
        @collection.to_a.collect {|item|
          item.to_s
        }
      end

      def ==(other)
        if self.equal?(other)
          return true
        elsif other.instance_of?(self.class)
          @collection == other.instance_variable_get(:@collection)
        else
          false
        end
      end

    end

  end
end
