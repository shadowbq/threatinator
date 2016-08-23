require 'threatinator/output'

module Threatinator
  module Plugins
    module Output
      require 'threatinator/plugins/output/json'
      class Json
        class Config < Threatinator::Output::Config
          attribute :file, String, description: "The hostname/ip of the RabbitMQ server"
        end
      end
    end
  end
end
