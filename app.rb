#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db = SQLite3::Database.new 'general.db'
	@db.results_as_hash = true
end

before do
	init_db
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
	@articles = @db.execute 'SELECT * FROM Articles ORDER BY id DESC'
	erb :index			
end

get '/newpost' do
	erb :newpost
end

post '/newpost' do
	@authorName = params[:authorName]
	@articleText = params[:articleText]

	if @authorName.length <= 0
		@error = "What about author name?"
		return erb :newpost
	elsif @articleText.length <= 0
		@error = "Try type article text"
		return erb :newpost
	end

	@db.execute 'INSERT INTO 
	Articles (
		createdDate, 
		authorName, 
		articleText
	) VALUES (
		datetime(), 
		?, 
		?
	)', [@authorName, @articleText]

	redirect to '/'
end

get '/details/:article_id' do
	article_id = params[:article_id]

	db = @db.execute 'SELECT * FROM Articles WHERE id=?', [article_id]
	@row = db[0]
	 
	erb :details
end