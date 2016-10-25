# Shadowbq-Threatinator

Threatinator is a ruby library for parsing threat data feeds.

## Code Status

[![Build Status](https://travis-ci.org/shadowbq/shadowbq-threatinator.svg?branch=master)](https://travis-ci.org/shadowbq/shadowbq-threatinator)
[![Code Climate](https://codeclimate.com/github/shadowbq/shadowbq-threatinator/badges/gpa.svg)](https://codeclimate.com/github/shadowbq/shadowbq-threatinator)
[![Test Coverage](https://codeclimate.com/github/shadowbq/shadowbq-threatinator/badges/coverage.svg)](https://codeclimate.com/github/shadowbq/shadowbq-threatinator)
[![Gem Version](https://badge.fury.io/rb/shadowbq-threatinator.png)](http://badge.fury.io/rb/shadowbq-threatinator)
[![Tags](https://img.shields.io/github/tag/shadowbq/threatinator.svg)](https://github.com/shadowbq/threatinator/releases)


## Fork

This is a fork published as `shadowbq-threatinator`

## Source code repository

The repository is located at: https://github.com/shadowbq/threatinator

## Development

First, set up your dependencies.

```
bundle install
```

### Listing feeds

```
bundle exec bin/threatinator list
provider           name                                 type  link/path                                                                            event_types                                     
-----------------  -----------------------------------  ----  ------------------------------------------------------------------------------------ ------------------------------------------------
abuse_ch           feodo_domain_reputation              http  https://feodotracker.abuse.ch/blocklist.php?download=domainblocklist                 [:c2]                                           
abuse_ch           feodo_ip_reputation                  http  https://feodotracker.abuse.ch/blocklist.php?download=ipblocklist                     [:c2]                                           
[..]
alienvault         ip_reputation                        http  https://reputation.alienvault.com/reputation.generic                                 [:scanning, :attacker, :malware_host, :spamming]
arbor              fastflux_domain_reputation           http  http://atlas.arbor.net/summary/domainlist                                            [:c2]                                           
arbor              ssh_ip_reputation                    http  http://atlas-public.ec2.arbor.net/public/ssh_attackers                               [:scanning]                                     
autoshun           shunlist                             http  http://www.autoshun.org/files/shunlist.csv                                           [:scanning]                                     

```

### Running a feed

```
bundle exec bin/threatinator run alienvault ip_reputation
```

### Using the AMQP output

```
bundle exec threatinator run --run.output.amqp.url=ENV['RABBITMQ_URL']} --run.output.format=amqp provider name
#    --run.output.amqp.routing_key=arg   - Routing key for Amqp events (default: none)
##        The routing key should be determined by the type
#    --run.output.amqp.url=arg           - The hostname/ip of the RabbitMQ server (default: none)
```

```
./bin/threatinator run --run.output.amqp.url='amqp://127.0.0.1' --run.output.format=amqp vxvault url_reputation
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

All issues for the fork are managed here: [shadowbq/threatinator/issues](https://github.com/shadowbq/threatinator/issues).

## Original License
Copyright (C) 2014 Michael Ryan (github.com/justfalter)

Original code: https://github.com/cikl/threatinator

See the LICENSE file for license rights and limitations (LGPLv3).
