# Threatinator
Threatinator is a ruby library for parsing threat data feeds. It is a component of [Cikl](https://github.com/cikl/cikl), a threat intelligence management system.
## Source code repository

The repository is located at: https://github.com/cikl/threatinator

## Development

First, set up your dependencies.

```
bundle install
```

### Listing feeds

```
bundle exec bin/threatinator list
```

### Running a feed

```
bundle exec bin/threatinator run alienvault ip_reputation
```

```
bundle exec threatinator run --run.output.amqp.url=ENV['RABBITMQ_URL']} --run.output.format=amqp provider name
#    --run.output.amqp.routing_key=arg   - Routing key for Amqp events (default: none)
##        The routing key should be determined by the type
#    --run.output.amqp.url=arg           - The hostname/ip of the RabbitMQ server (default: none)
```

### Getting help

All commands respond to '--help' to provide details on their usage.

```
bundle exec bin/threatinator run --help

NAME
    run - fetch and parse a feed

SYNOPSIS
    threatinator [global options] run [command options]

COMMAND OPTIONS
    --run.coverage_output=arg           - Write coverage analysis to the specified file (CSV format) (default: none)
    --run.feed_name=arg                 - The feed name (default: none)
    --run.feed_provider=arg             - The feed provider (default: none)
    --run.fetch_from_file=arg           - Read data from the specified file rather than fetching (default: none)
    --run.output.amqp.routing_key=arg   - Routing key for Amqp events (default: none)
    --run.output.amqp.url=arg           - The hostname/ip of the RabbitMQ server (default: none)
    --run.output.csv.filename=arg       - Path to the file where output will be written (default: none)
    --run.output.format=arg             - Output format (amqp, csv, json, null, rubydebug) (default: none)
    --run.output.json.file=arg          - The hostname/ip of the RabbitMQ server (default: none)
    --run.output.rubydebug.filename=arg - Path to the file where output will be written (default: none)

```

## Contributing and Issue Tracking

Before you file a bug or submit a pull request, please review our
[contribution guidelines](https://github.com/cikl/cikl/wiki/Contributing).

All issues are managed here: [cikl/threatinator/issues](https://github.com/cikl/threatinator/issues).

## License
Copyright (C) 2014 Michael Ryan (github.com/justfalter)

See the LICENSE file for license rights and limitations (LGPLv3).
