module Redisplay
  module Field
    class Set
      include Field
      
      def initialize(key)
        @value = Redisplay.redis.smembers(key)
      end
      
    end
  end
end