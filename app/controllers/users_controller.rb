require 'pry'

class UsersController < ApplicationController

   get '/signup' do
    if !logged_in?
		  erb :"users/create_user"
    else
      redirect to "/tweets"
    end
	end

  post '/signup' do
		if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
		else
			@user = User.create(params)
      session[:user_id] = @user.id
			redirect to "/tweets"
		end
	end

   get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect to "/tweets"
    end
  end

   post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/show"
  end

   get '/logout' do
    if !logged_in?
      redirect to "/"
    else
      session.destroy
      redirect to "/login"
    end
  end


 end
