require 'threatinator/output'
require 'multi_json'
#require 'pry'
module Threatinator
  module Plugins
    module Output

      class Json < Threatinator::Output
        #include JSONHelpers
        require 'threatinator/plugins/output/json/config'

        def initialize(config)
          @output_file = config.file
          @first = true
          puts "{"
        end

        def handle_event(event)
          if @first
            puts "\"header\" : #{MultiJson.dump(event.header.to_h)}"
            puts ",\"items\" : ["
            puts "{"
            @first = false
          else
            puts ",{"
          end
          delim = ""
          if event.ipv4s.size > 0
            puts "#{delim}\"ipv4s\" : #{MultiJson.dump(event.ipv4s.list)}"
            delim = ","
          end
          if event.fqdns.size > 0
            puts "#{delim}\"fqdns\" : #{MultiJson.dump(event.fqdns.list)}"
            delim = ","
          end
          if event.urls.size > 0
            puts "#{delim}\"urls\" : #{MultiJson.dump(event.urls.list)}"
            delim = ","
          end
          puts "}"

        end

        def finish
          puts "]}"
        end



      end
    end
  end
end
