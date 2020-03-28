require 'sinatra'
require 'active_record'
require './models/country'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/boiler_db')


get '/' do
  erb :index
end

get '/addcountry' do

  country  = Country.create(name: params[:name])
  redirect '/'
end
