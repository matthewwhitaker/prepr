require 'sinatra/base'
require './lib/post'

class Peepr < Sinatra::Base
  get '/' do
    'Hello, World!'
  end

  get '/posts' do
    posts = Post.all
    erb :'views/posts'
  end

  run! if app_file == $0
end
