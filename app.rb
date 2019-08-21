#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'general.db'
	@db.results_as_hash = true
end

configure do
	init_db
	@db.execute 'CREATE TABLE IF NOT EXISTS 
	Articles (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		createdDate DATA,
		authorName TEXT,
		articleText TEXT
	)'
end

get '/' do
	erb "Wow hellooo"			
end

get '/newpost' do
	erb :newpost
end

post '/newpost' do
	authorName = params[:authorName]
	articleText = params[:articleText]

	erb "Введено<br /> #{authorName}<br /> #{articleText}"
end