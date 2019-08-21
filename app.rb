#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/newpost' do
	erb :newpost
end

post '/newpost' do
	authorName = params[:authorName]
	articleText = params[:articleText]

	erb "Введено<br /> #{authorName}<br /> #{articleText}"
end