require 'sinatra'
class Application < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :logging, true

  get '/' do
    haml :index
    #send_file 'views/stackdom.out'
  end
end

