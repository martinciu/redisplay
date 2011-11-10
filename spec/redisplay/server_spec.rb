require 'spec_helper'

describe Redisplay::Server do
  include Rack::Test::Methods

  def app
    @app ||= Redisplay::Server
  end

  before(:each) do
    Redisplay.redis.flushall
    Redisplay.redis.set('mystring', 'string')
    Redisplay.redis.set('hisstring', 'hisstring')
    Redisplay.redis.hset('myhash', "foo", "1")
    Redisplay.redis.hset('myhash', "bar", "2")
    Redisplay.redis.lpush('list', "foo")
    Redisplay.redis.lpush('list', "bar")
    Redisplay.redis.sadd('set', "foo")
    Redisplay.redis.sadd('set', "bar")
    Redisplay.redis.zadd('zset', 2, "foo")
    Redisplay.redis.zadd('zset', 1, "bar")
  end

  it "should respond to /" do
    get '/'
    last_response.ok?.must_equal true
  end

  it "/keys/*my* fetche key patern *my*" do
    get '/keys/*my*'
    last_response.status.must_equal 200
    last_response['Content-Type'].must_equal 'application/json;charset=utf-8'
    last_response.body.must_equal "[\"myhash\",\"mystring\"]"
  end

  describe "key" do
    it "/key/mystring returns string" do
      get '/key/mystring'
      last_response.status.must_equal 200
      last_response['Content-Type'].must_equal 'application/json;charset=utf-8'
      last_response.body.must_equal "\"string\""
    end

    it "/key/myhash returns hash" do
      get '/key/myhash'
      last_response.status.must_equal 200
      last_response['Content-Type'].must_equal 'application/json;charset=utf-8'
      last_response.body.must_equal "{\"foo\":\"1\",\"bar\":\"2\"}"
    end

    it "/key/list returns list" do
      get '/key/list'
      last_response.status.must_equal 200
      last_response['Content-Type'].must_equal 'application/json;charset=utf-8'
      last_response.body.must_equal "[\"bar\",\"foo\"]"
    end

    it "/key/set returns set" do
      get '/key/set'
      last_response.status.must_equal 200
      last_response['Content-Type'].must_equal 'application/json;charset=utf-8'
      last_response.body.must_equal "[\"foo\",\"bar\"]"
    end

    it "/key/zset returns sortedset" do
      get '/key/zset'
      last_response.status.must_equal 200
      last_response['Content-Type'].must_equal 'application/json;charset=utf-8'
      last_response.body.must_equal "[\"bar\",\"foo\"]"
    end
  end
end