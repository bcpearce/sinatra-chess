require 'rubygems'
require 'bundler'

Bundler.require

require './sinatra-chess'
run Sinatra::Application
