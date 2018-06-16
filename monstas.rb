require 'sinatra'
require 'sinatra/reloader'

get '/' do
  'OMG, hello Ruby Monstas!'
end

get '/signup' do
  'Here you can sign up for the next beginners course.'
end

post '/signin' do

end

get '/monstas/:name' do
  'Hello ' + params['name'] + '!'
end