require "sinatra/flash"
require "sinatra/base"
require "./database_connection_setup"
require 'bcrypt'


class MakersBnB < Sinatra::Base
  get "/" do

    redirect('users/new')

  end

  get "/users/new" do
    erb :'users/new'
  end

  post "/users" do
    User.create(email: params[:email],password: params[:password])
    redirect('/spaces')
  end

  get "/spaces" do

    erb :'spaces/index'

  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
