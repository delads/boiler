require './models/record'

get '/' do
  erb :index
end

get '/records' do
  @records = Record.all
  erb :records
end

get '/addrecord' do
  Record.create(name: params[:name])
  redirect '/records'
end
