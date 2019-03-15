class UsersController < ApplicationController
  #renders new user form
  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      redirect to '/games'
    end
  end

  #creates user and saves to database
  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect '/login'
    end
  end

  #shows form for user to login
  get '/login' do
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/games'
    end
    # erb :'users/login'
  end

  #checks to see if info is correct then logs in the user
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/games'
    else
      erb :'users/error'
    end
  end

  #ends the session(logging out the user)
  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
