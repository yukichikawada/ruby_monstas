require 'sinatra'
require 'sinatra/reloader'
require 'erb'

get '/' do
  'OMG, hello Ruby Monstas!'
end

get '/signup' do
  'Here you can sign up for the next beginners course.'
end

post '/signin' do

end

get '/monstas/:name' do
  @name = params['name']
  erb :monstas
end

get '/monstas' do
  @name = params['name']
  write_name_to_file("names.txt", @name)
  erb :monstas
end

def write_name_to_file(filename, arg)
  File.open('names.txt', 'a+') do |file|
    file.puts(@name)
  end
end