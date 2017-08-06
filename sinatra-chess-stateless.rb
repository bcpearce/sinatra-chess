#Sinatra Chess Stateless
require_relative 'game_helper.rb'

class SinatraChessStateless < Sinatra::Base 

  register Sinatra::CrossOrigin

  get '/' do
    "GET /game/new for new game instance"
  end

  get '/game/new' do
    cross_origin
    Game.new.to_json
  end

  post '/game/move' do 
    cross_origin
    data = JSON.parse request.body.read
    game = YAML.load(data['serial'])
    move = data['move']
    body(process_move(game, move))
    status 200
  end

end