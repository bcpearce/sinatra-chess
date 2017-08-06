require 'rubygems'
require 'bundler'

Bundler.require

puts "Sinatra version: " + Sinatra::VERSION
puts "Chess version: " + Chess::VERSION

require './sinatra-chess-stateless'

run Rack::URLMap.new(
  "/api/v1" => SinatraChessStateless.new);

