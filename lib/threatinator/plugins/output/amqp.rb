require 'threatinator/output'
require 'bunny'
require 'multi_json'

# bundle exec threatinator run --run.output.amqp.url=#{ENV['RABBITMQ_URL']} --run.output.format=amqp #{provider} #{name}"
#    --run.output.amqp.routing_key=arg   - Routing key for Amqp events (default: none)
#    --run.output.amqp.url=arg           - The hostname/ip of the RabbitMQ server (default: none)


module Threatinator
  module Plugins
    module Output
      class Amqp < Threatinator::Output
        require 'threatinator/plugins/output/amqp/config'

        def initialize(config)
          bunny_config = {
            recover_from_connection_close: true,
            network_recovery_interval: 5.0
          }
          @bunny = Bunny.new(config.url, bunny_config)
          @bunny.start
          @channel = @bunny.create_channel
          @exchange = @channel.topic("threats")
        end

        def handle_event(event)
          # Routing keys are dynamic event_types
          #@routing_key = config.routing_key || 'threatinator.' + event.type.to_s
          @routing_key = 'threatinator.' + event.type.to_s
          @exchange.publish(MultiJson.dump(event.to_serializable_hash),
                            routing_key: @routing_key)
        end

        def finish
          @exchange = nil
          @bunny.close
        end

      end
    end
  end
end
