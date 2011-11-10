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
    Redisplay.redis.hset('myhash', "bar", "1")
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

end