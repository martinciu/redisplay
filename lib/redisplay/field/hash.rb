module Redisplay
  module Field
    class Hash
      include Field
      
      def initialize(key)
        @value = Redisplay.redis.hgetall(key)
      end

    end
  end
end