require 'sinatra'
require 'dalli'
require 'chess'

options = { :namespace => "app_v1", :compress => true }
cache = Dalli::Client.new('localhost:11211', options)

enable :sessions

not_found do
  "404 NOT FOUND\n"
end

get '/' do
  "Click <a href = '/new_game'>here</a> to start a new game"
end

get '/new_game' do
  @game = Game.new

  cache.set("game", @game)
  redirect to('/game')

end

get '/game' do
  @game = cache.get("game")
  @board = @game.board
  erb :game, locals: {list: @board}
end

post '/game' do
  loc1 = params[:initial_position]
  loc2 = params[:new_position]
  @game = cache.get(:game)
  @board = @game.board
  @board.move(loc1.upcase, loc2.upcase)
  cache.set(:game, @game)
  erb :game, locals: {list: @board}
end
