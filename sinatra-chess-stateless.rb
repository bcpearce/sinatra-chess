#Sinatra Chess Stateless
require_relative 'game_helper.rb'

class SinatraChessStateless < Sinatra::Base 

  register Sinatra::CrossOrigin

  configure do 
    enable :cross_origin
  end

  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = 
      "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  end

  get '/' do
    "GET /game/new for new game instance"
  end

  get '/game/new' do
    Game.new.to_json
  end

  post '/game/move' do 
    data = JSON.parse request.body.read
    game = YAML.load(data['serial'])
    move = data['move']
    body(process_move(game, move))
    status 200
  end

  post '/game/promote' do
    data = JSON.parse request.body.read
    puts(data);
    game = YAML.load(data['serial'])
    piece = data['piece']
    body(process_promote(game, piece))
    status 200
  end

end