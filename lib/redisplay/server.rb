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
  
  end

    get '/' do
      erb :index
    end

    get '/keys/:pattern' do
      render_json Redisplay.redis.keys(params[:pattern]).sort.first(100)
    end

  end
end