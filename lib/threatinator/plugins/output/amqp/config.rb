require 'threatinator/output'

module Threatinator
  module Plugins
    module Output
      require 'threatinator/plugins/output/amqp'
      class Amqp
        class Config < Threatinator::Output::Config
          attribute :url, String, description: "The hostname/ip of the RabbitMQ server"

          attribute :routing_key, String, default: lambda { |c,a| 'amqp.event' },
            description: "Routing key for Amqp events"

        end
      end
    end
  end
end
