require "sinatra/flash"
require "sinatra/base"
require "./database_connection_setup"
require "./lib/space"

class MakersBnB < Sinatra::Base
  get "/" do
    "Hello MakersBnB!"
  end

  get '/spaces' do
    "Hello Spaces"
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post "/spaces" do
    Space.create(name: params[:name], description: params[:description], price: params[:price], date_available_from: params[:date_available_from], date_available_to: params[:date_available_to])
    redirect('/spaces')
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
