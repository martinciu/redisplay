require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
Bundler.require(:default, :test)
require 'rack/test'

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'
$TESTING = true
require 'minitest/spec'
require 'minitest/autorun'
require 'turn'
require 'mocha'
require 'rack/test'

require 'redisplay'

if !ENV['TRAVIS']

  # make sure we can run redis

  if !system("which redis-server")
    puts '', "** can't find `redis-server` in your path"
    puts "** try running `sudo rake install`"
    abort ''
  end

  #
  # start our own redis when the tests start,
  # kill it when they end
  #

  at_exit do
    next if $!

    if defined?(MiniTest)
      exit_code = MiniTest::Unit.new.run(ARGV)
    else
      exit_code = Test::Unit::AutoRunner.run
    end

    pid = `ps -A -o pid,command | grep [r]edis-test`.split(" ")[0]
    puts "Killing test redis server..."
    `rm -f #{dir}/dump.rdb`
    Process.kill("KILL", pid.to_i)
    exit exit_code
  end

  puts "Starting redis for testing at localhost:9736..."
  `redis-server #{dir}/redis-test.conf`
  Redisplay.redis = 'localhost:9736'
end

