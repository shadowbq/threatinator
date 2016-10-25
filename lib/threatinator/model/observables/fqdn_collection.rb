require 'threatinator/model/collection'
require 'domain_name_validator'

module Threatinator
  module Model
    module Observables
      class FqdnCollection < Threatinator::Model::Collection
        def valid_member?(v)
          #v.is_a?(::String)
          ::DomainNameValidator.new.validate(v.to_s)
        end
      end
    end
  end
end
