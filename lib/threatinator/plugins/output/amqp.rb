require 'threatinator/output'
require 'bunny'
require 'cikl/event'
require 'multi_json'

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
          @exchange = @bunny.create_channel.default_exchange
          @routing_key = config.routing_key
        end

        def handle_event(event)
          binding.pry
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
