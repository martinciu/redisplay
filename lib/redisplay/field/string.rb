module Redisplay
  module Field
    class String
      include Field

      def initialize(key)
        @value = Redisplay.redis.get(key)
      end

    end
  end
end