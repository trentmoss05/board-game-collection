class BoardGamesController < ApplicationController

  get '/games' do
    redirect_if_not_logged_in
    @games = BoardGame.all
    erb :'board_games/index'
  end

  get '/games/new' do
    redirect_if_not_logged_in
    @error_message = params[:error]
    erb :'board_games/new'
  end

  post '/games' do
    redirect_if_not_logged_in
    BoardGame.create(name: params[:name], game_type: params[:game_type], playtime: params[:playtime], playercount: params[:playercount])
    redirect '/games'
  end

end
