require "sinatra/flash"
require "sinatra/base"
require "./database_connection_setup"
require 'bcrypt'
require_relative './lib/space'
require_relative './lib/request'
require_relative './session_helper'


class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  register Sinatra::Flash
  include SessionHelper


  get "/" do
    redirect('users/new')
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  get '/spaces/filter' do
    @spaces = Space.filter(from: params[:available_from], to: params[:available_to])
    erb :'spaces/index'
  end

  get "/spaces" do
    @user = current_user
    @spaces = Space.all
    erb :'spaces/index'
  end

  post "/spaces" do
    Space.create(name: params[:name], description: params[:description], price: params[:price], date_available_from: params[:date_available_from], date_available_to: params[:date_available_to], user_id: session[:user_id])
    redirect('/spaces')
  end

  get "/users/new" do
    erb :'users/new'
  end

  post "/users" do
    user = User.create(email: params[:email],password: params[:password], username: params[:username])
    session[:user_id] = user.id
    redirect('/spaces')
  end

  get "/spaces/:id" do
    @space = Space.find(id: params[:id])
    erb :'requests/new'
  end

  post "/requests/:id" do
    result = Request.create(user_id: session[:user_id], requested_date: params[:requested_date], space_id: params[:id])
    if result
      redirect '/spaces'
    else
      flash[:notice] = 'Space already booked for that date'
      redirect "/spaces/#{params[:id]}"
    end
  end


  patch "/requests/:id" do
    Request.update_status(id: params[:id], status: params[:status])
    redirect('/requests')
  end

  get "/requests/:id" do
    @rqst = Request.find(id: params[:id])
    @space = Space.find(id: @rqst.space_id)
    @user = User.find(id: @rqst.user_id)
    erb :'requests/edit'
  end

  get '/requests' do
    @requests_made = Request.all_made(user_id: session[:user_id])
    @requests_received = Request.all_received(user_id: session[:user_id])
    erb :'requests/index'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash[:notice] = 'Please check your email or password'
      redirect '/sessions/new'
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out'
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
