require 'sinatra/base'
require './lib/post'

class Peepr < Sinatra::Base
  get '/' do
    'Hello, World!'
  end

  get '/posts' do
    posts = Post.all
    erb :'posts'
  end

  get '/posts/new' do
    erb :'new'
  end

  post '/posts/new' do
    Post.add(body: params[:post_body], title: params[:post_title])
    redirect('/posts')
  end

  run! if app_file == $0
end
