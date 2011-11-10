require 'spec_helper'

describe Redisplay::Server do
  include Rack::Test::Methods

  def app
    @app ||= Redisplay::Server
  end

  before(:each) do
    Redisplay.redis.flushall
  end

  it "should respond to /" do
    get '/'
    last_response.ok?.must_equal true
  end

end