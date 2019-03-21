class BoardGamesController < ApplicationController

  get '/games' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    games = BoardGame.all
    @user_games = []
    games.each do |game|
      if game.user_id == session[:user_id]
        @user_games << game
      end
    end
    erb :'board_games/index'
  end

  get '/games/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'board_games/new'
  end

  get '/games/:id/edit' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    @game = BoardGame.find_by_id(params[:id])
    if current_user != @game.user
      redirect to '/games'
    end
    erb :'board_games/edit'
  end

  patch '/games/:id' do
    @game = BoardGame.find_by_id(params[:id])
    @game.name = params[:name]
    @game.game_type = params[:game_type]
    @game.playtime = params[:playtime]
    @game.playercount = params[:playercount]
    @game.save
    redirect to "/games/#{@game.id}"
  end


  post '/games' do
    redirect_if_not_logged_in
    @game = BoardGame.create(name: params[:name], game_type: params[:game_type], playtime: params[:playtime], playercount: params[:playercount], user_id: session[:user_id])
    redirect "/games/#{@game.id}"
  end

  get '/games/:id' do
    redirect_if_not_logged_in
    @game = BoardGame.find_by_id(params[:id])
    if current_user != @game.user
      redirect to '/games'
    end
    erb :'board_games/show'
  end

  delete '/games/:id/delete' do
    @game = BoardGame.find_by_id(params[:id])
    if current_user != @game.user
      redirect to '/games'
    end
    @game.delete
    redirect to '/games'
  end

end
