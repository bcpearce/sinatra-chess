require 'sinatra'

options = { :namespace => "app_v1", :compress => true }
# cache = Dalli::Client.new('localhost:9292', options)

game = Game.new
enable :sessions

not_found do
  "404 NOT FOUND\n"
end

get '/' do
  "Click <a href = '/new_game'>here</a> to start a new game"
end

get '/new_game' do
  game = Game.new

  redirect to('/game')
end

get '/game' do
  @board = game.board
  @player = game.turn
  erb :game, locals: { list: [@board, @player] }
end

post '/game' do
  loc1 = params[:initial_position]
  loc2 = params[:new_position]
  @board = game.board
  @player = game.turn
  @opponent = game.opponent

  unless @player.move(loc1.upcase.strip, loc2.upcase.strip, @board).nil?
    game.turn, game.opponent = game.opponent, game.turn
    @player = game.turn
  end

  @check =
    if @player.king(@board).checkmate?(@board)
      :checkmate
    elsif @player.king(@board).check?(@board)
      :check
    end

  erb :game, locals: { list: [@board, @player, @check] }
end
