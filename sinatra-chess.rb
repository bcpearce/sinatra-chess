require 'sinatra'

options = { :namespace => "app_v1", :compress => true }
# cache = Dalli::Client.new('localhost:9292', options)

game = Game.new
enable :sessions

not_found do
  "404 NOT FOUND\n"
end

get '/' do
  erb :game
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

get '/promote' do
  @board = game.board
  @player = game.opponent
  @promotion = true
  erb :game, locals: { list: [@baord, @player, @promotion]}
end

get '/promote/:piece' do
  @board = game.board
  promote = @board.piece_to_promote?
  @board.promote(promote.location, params[:piece].to_sym) if promote
  redirect to('/game')
end

post '/game' do
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
    @status = "That is not your piece!"
  elsif @player.king(@board).will_be_in_check?(loc1, loc2, @board)
    @status = "That move will put you in check!"
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
