require 'sinatra'
require 'securerandom'

enable :sessions

games = Hash.new
game = nil

use Rack::Session::Cookie,  :key => 'SESSION_ID',
                            :expire_after => 60*60*24, # one day
                            :secret => 'remember the game'

before do
  session[:id] ||= SecureRandom.uuid
  game = games[session[:id]]
end

not_found do
  "404 NOT FOUND\n"
end

get '/' do
  erb :game
end

get '/new_game' do
  @game = Game.new
  games[session[:id]] = @game
  redirect to('/game')
end

get '/game' do
  if game.nil?
    redirect to('/')
  end
  @board = game.board
  @player = game.turn
  erb :game, locals: { list: [@board, @player] }
end

get '/promote' do
  @board = game.board
  @player = game.opponent
  @promotion = true
  erb :game, locals: { list: [@baord, @player, @promotion]}
end

get '/promote/:piece' do
  @board = game.board
  promote = @board.piece_to_promote?
  @board.promote(promote.location, params[:piece])
  redirect to('/game')
end

post '/game' do
  if game.nil?
    redirect to('/')
  end

  loc1 = params[:initial_position]
  loc2 = params[:new_position]
  @board = game.board
  @player = game.turn
  @opponent = game.opponent

  if @player.move(loc1.upcase.strip, loc2.upcase.strip, @board)
    game.turn, game.opponent = game.opponent, game.turn
    @player = game.turn
    @opponent = game.opponent
  elsif @board[loc1].is_a?(Piece) && @board[loc1].color != @player.color
    @status = "Invalid move! That is not your piece!"
  else
    error_msg = @board.move_status.nil? ? "" : @board.move_status
    @status = "Invalid move! " + error_msg
  end

  @check =
    if @player.king(@board).checkmate?(@board)
      :checkmate
    elsif @player.king(@board).check?(@board)
      :check
    end

  if @board.piece_to_promote?
    redirect to('/promote')
  else
    erb :game, locals: { list: [@board, @player, @check, @status] }
  end

end
