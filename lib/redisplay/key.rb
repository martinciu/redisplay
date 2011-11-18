module Redisplay
  class Key
    def self.all(pattern)
      Redisplay.redis.keys(pattern)
    end
  end
end