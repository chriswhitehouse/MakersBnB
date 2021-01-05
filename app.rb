require "sinatra/flash"
require "sinatra/base"
require "./database_connection_setup"

class MakersBnB < Sinatra::Base
  get "/" do
    "Hello MakersBnB!"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
