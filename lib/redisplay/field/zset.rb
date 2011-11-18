module Redisplay
  module Field
    class Zset
      include Field

      def initialize(key)
        @value = Redisplay.redis.zrange(key, 0, -1)
      end

    end
  end
end