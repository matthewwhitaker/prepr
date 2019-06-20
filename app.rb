require 'sinatra/base'
require 'sinatra/flash'
require './lib/post'
require './db/scripts/db_setup'
require './lib/user'

class Peepr < Sinatra::Base
  register Sinatra::Flash
  enable :sessions, :method_override

  get '/' do
    redirect('/posts')
  end

  get '/posts' do
    @posts = Post.all
    @user = User.find(id: session[:user_id])
    erb :'index'
  end

  get '/posts/new' do
    erb :'posts/new_post'
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
    erb :'posts/edit_post'
  end

  patch '/posts/:id' do
    Post.update(id: params[:id], body: params[:post_body], title: params[:post_title])
    flash[:notice] = 'Post was updated.'
    redirect('/posts')
  end

  get '/users/new' do
    erb :'users/signup'
  end

  post '/users/new' do
    current_user = User.create(email: params[:email], username: params[:username], password: params[:password])
    session[:user_id] = current_user.id
    flash[:notice] = "Welcome, #{current_user.username}!"
    redirect('/posts')
  end

  get '/sessions/new' do
    erb :'users/sign_in'
  end

  post '/sessions/new' do
    user = User.authenticate(email: params[:email], password: params[:password])

    if user
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.username}!"
      redirect('/posts')
    else
      flash[:notice] = 'incorrect email/password combination.'
      redirect('/sessions/new')
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have been successfully signed out.'
    redirect('/posts')
  end

  run! if app_file == $0
end
