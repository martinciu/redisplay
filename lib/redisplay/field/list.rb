module Redisplay
  module Field
    class List
      include Field
      
      def initialize(key)
        len = Redisplay.redis.llen(key)
        @value = []
        for i in 0..len - 1
          @value << Redisplay.redis.lindex(key, i)
        end
      end

    end
  end
end