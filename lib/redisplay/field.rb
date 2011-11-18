require "redisplay/field/hash"
require "redisplay/field/list"
require "redisplay/field/set"
require "redisplay/field/string"
require "redisplay/field/zset"

module Redisplay
  module Field
    
    def self.included(base)
      base.attr_accessor :value
    end

    def self.new(key)
      type = Redisplay.redis.type(key)
      type[0] = type[0,1].upcase
      Redisplay::Field.const_get(type).new(key)
    rescue
      nil
    end

    def to_s
      @value.to_s
    end

  end
end