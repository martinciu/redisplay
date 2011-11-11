require 'sinatra/base'

module Redisplay
  class Server < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public_folder, "#{dir}/server/public"
    set :static, true
    set :method_override, true

    helpers do
      def url(*path_parts)
        [ path_prefix, path_parts ].join("/").squeeze('/')
      end

      def path_prefix
        request.env['SCRIPT_NAME']
      end
    
      def render_json(body)
        content_type :json
        body.to_json
      end

      def render_text(body)
        content_type 'text/plain', :charset => 'utf-8'
        body.to_s
      end

      def redis
        @redis ||= Redisplay.redis
      end

      def value(key)
        case redis.type(key)
          when "string" then redis.get(key)
          when "hash" then redis.hgetall(key)
          when "list" then
            len = redis.llen(key)
            list = []
            for i in 0..len - 1
              list << redis.lindex(key, i)
            end
            list
          when "set" then redis.smembers(key)
          when "zset" then redis.zrange(key, 0, -1)
          else ""
        end
      end
  
    end

    get '/' do
      erb :index
    end

    get '/keys/:pattern' do
      render_json redis.keys(params[:pattern]).sort.first(100)
    end

    get '/key/*' do |key|
      render_text value(key)
    end

  end
end