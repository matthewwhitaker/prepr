require 'sinatra/base'
require 'sinatra/flash'
require './lib/post'

class Peepr < Sinatra::Base
  register Sinatra::Flash
  enable :sessions, :method_override

  get '/' do
    redirect('/posts')
  end

  get '/posts' do
    @posts = Post.all
    erb :'index'
  end

  get '/posts/new' do
    erb :'new'
  end

  post '/posts/new' do
    Post.add(body: params[:post_body], title: params[:post_title])
    redirect('/posts')
  end

  delete '/posts/:id' do
    Post.delete(id: params[:id])
    flash[:notice] = 'Post was deleted.'
    redirect('/posts')
  end

  get '/posts/:id/edit' do
    @post = Post.find(id: params[:id])
    erb :'edit'
  end

  patch '/posts/:id' do
    Post.update(id: params[:id], body: params[:post_body], title: params[:post_title])
    flash[:notice] = 'Post was updated.'
    redirect('/posts')
  end

  run! if app_file == $0
end
