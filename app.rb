require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/model'
require_relative 'twitterwhack'
require 'byebug'    #Twitterwhack class


get '/' do
	erb :index
end

post '/submit' do
	@result = TwitterWhack.new(params[:first_word], params[:second_word], 100)
	erb :results
end
