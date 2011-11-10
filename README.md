# Redisplay[![travis-ci](https://secure.travis-ci.org/martinciu/redisplay.png?branch=master)](http://travis-ci.org/martinciu/redisplay)
### Simple Rack app for browsing Redis database

## Setup

If you are using bundler add redisplay to your Gemfile:

    gem 'redisplay'

Then run:

    bundle install

Otherwise install the gem:

    gem install redisplay

and require it in your project:

    require 'redisplay'

## Usage

### Standalone service

Redisplay can be deployed as a standalone service (for example to heroku). To do it create a simple `config.ru` file:

    require 'rubygems'
    require 'redisplay'

    # Redisplay.redis = ENV['REDISTOGO_URL'], read below about redis configuration

    run Redisplay::Server.new

and deploy it to any `rack` compatybile environment (passenger, thin, unicorn, etc.)

### Mounted to the Rails app

Mount Redisplay in your `config/routes.rb` file:

    mount Redisplay::Server.new => "redisplay", :as => "redisplay"

It will be available under `http://yourapproot.tld/redisplay` url

## Configuration

### Redis

You may want to change the Redis host and port Redisplay connects to, or
set various other options at startup.

Redisplay has a `redis` setter which can be given a string or a Redis
object. This means if you're already using Redis in your app, Redisplay
can re-use the existing connection.

String: `Redisplay.redis = 'localhost:6379'`

Redis: `Redisplay.redis = $redis`

For our rails app we have a `config/initializers/redisplay.rb` file where
we load `config/redisplay.yml` by hand and set the Redis information
appropriately.

Here's our `config/redis.yml`:

    development: localhost:6379
    test: localhost:6379
    staging: redis1.example.com:6379
    fi: localhost:6379
    production: redis1.example.com:6379

And our initializer:

    rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
    rails_env = ENV['RAILS_ENV'] || 'development'

    redis_config = YAML.load_file(rails_root + '/config/redis.yml')
    Redisplay.redis = redis_config[rails_env]

## Namespaces

If you're running multiple, separate instances of redisplay you may want
to namespace the keyspaces so they do not overlap. This is not unlike
the approach taken by many memcached clients.

This feature is provided by the [redis-namespace][rs] library, which
redisplay uses by default to separate the keys it manages from other keys
in your Redis server.

Simply use the `Redisplay.redis.namespace` accessor:

    Redisplay.redis.namespace = "blog:production"

We recommend sticking this in your initializer somewhere after Redis
is configured.

## Results

There isn't any dashboard for displaying values (yet). You cen review them by logging into `redis-cli`. Sorry.

## Development

Source hosted at [GitHub](http://github.com/martinciu/redisplay).
Report Issues/Feature requests on [GitHub Issues](http://github.com/martinciu/redisplay/issues).

Tests can be ran with `rake test`

### Note on Patches/Pull Requests

 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so I don't break it in a
   future version unintentionally.
 * Commit, do not mess with rakefile, version, or history.
   (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
 * Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Marcin Ciunelis. See [LICENSE](https://github.com/martinciu/redisplay/blob/master/LICENSE) for details.
