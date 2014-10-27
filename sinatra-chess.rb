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
  erb :game, locals: {list: @board}
end

post '/game' do
  loc1 = params[:initial_position]
  loc2 = params[:new_position]
  @board = game.board
  @player = game.turn
  @player.move(loc1.upcase, loc2.upcase, @board)
  game.turn, game.opponent = game.opponent, game.turn
  puts "#{@player.color}'s turn"
  erb :game, locals: {list: @board}
end
