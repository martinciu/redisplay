require 'rubygems'
require 'bundler'

Bundler.require

require 'redisplay'

# Redisplay.redis = ENV['REDISTOGO_URL']

run Redisplay::Server