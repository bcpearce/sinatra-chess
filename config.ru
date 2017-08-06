require 'rubygems'
require 'bundler'

Bundler.require

puts "Sinatra version: " + Sinatra::VERSION
puts "Chess version: " + Chess::VERSION

#require './sinatra-chess'
require './sinatra-chess-stateless'
#run SinatraChess
run SinatraChessStateless

