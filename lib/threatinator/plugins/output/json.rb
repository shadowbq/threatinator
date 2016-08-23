require 'threatinator/output'
require 'multi_json'
require 'pry'

module Threatinator
  module Plugins
    module Output


      class Json < Threatinator::Output
        #include JSONHelpers
        require 'threatinator/plugins/output/json/config'

        def initialize(config)
          @output_file = config.file
        end

        def handle_event(event)
          binding.pry
          puts MultiJson.dump(event)
        end

        def finish
        end



      end
    end
  end
end
