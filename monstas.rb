require 'sinatra'
require 'sinatra/reloader'
require 'erb'

enable :sessions

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

class NameValidator
  def initialize(name, names)
    @name = name.to_s
    @names = names
  end
  
  def valid?
    validate
    @message.nil?
  end

  def message
    @message
  end

  private

  def validate
    if @name.empty?
      @message = "A name must be present."
    elsif @names.include?(@name)
      @message = "#{@name} is already on the list."
    end
  end
end

get '/monstas' do
  @message = session.delete(:message)
  @name = params['name']
  @names = read_names
  erb :monstas
end

post '/monstas' do
  @name = params['name']
  @names = read_names
  validator = NameValidator.new(@name, @names)

  if validator.valid?
    write_name_to_file("names.txt", @name)
    session[:message] = "Succesfully saved the name #{@name}."
    redirect "/monstas?name=#{@name}"
  else
    @message = validator.message
    erb :monstas
  end
end

def write_name_to_file(filename, arg)
  File.open('names.txt', 'a+') do |file|
    file.puts(@name)
  end
end

def read_names
  return [] unless File.exists?('names.txt')
  File.read('names.txt').split("\n")
end