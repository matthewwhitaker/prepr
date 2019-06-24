require 'sinatra/base'
require 'sinatra/flash'
require './lib/post'
require './db/scripts/db_setup'
require './lib/user'

class Prepr < Sinatra::Base
  register Sinatra::Flash
  enable :sessions, :method_override

  get '/' do
    redirect('/posts')
  end

  get '/posts' do
    @posts = Post.all
    @user = User.find(id: session[:user_id])
    erb :'index.html', layout: :'application.html'
  end

  get '/posts/new' do
    if session[:user_id]
      erb :'posts/new_post.html', layout: :'application.html'
    else
      flash[:notice] = JSON.parse(File.read('user_messages.json'))['login_required']
      redirect('/sessions/new')
    end
  end

  post '/posts/new' do
    Post.add(body: params[:post_body], title: params[:post_title], user_id: session[:user_id])
    redirect('/posts')
  end

  delete '/posts/:id' do
    Post.delete(id: params[:id])
    flash[:notice] = JSON.parse(File.read('user_messages.json'))['post_deleted']
    redirect('/posts')
  end

  get '/posts/:id/edit' do
    @post = Post.find(id: params[:id])
    erb :'posts/edit_post.html', layout: :'application.html'
  end

  patch '/posts/:id' do
    Post.update(id: params[:id], body: params[:post_body], title: params[:post_title])
    flash[:notice] = JSON.parse(File.read('user_messages.json'))['post_updated']
    redirect('/posts')
  end

  get '/users/new' do
    erb :'users/signup.html', layout: :'application.html'
  end

  post '/users/new' do
    unless (params[:email] == '' || params[:username] == '' || params[:password] == '')
      current_user = User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = current_user.id
      flash[:notice] = JSON.parse(File.read('user_messages.json'))['sign_up_success']
      redirect('/posts')
    else
      flash[:notice] = JSON.parse(File.read('user_messages.json'))['missing_fields']
      redirect('/users/new')
    end
  end

  get '/sessions/new' do
    erb :'users/sign_in.html', layout: :'application.html'
  end

  post '/sessions/new' do
    user = User.authenticate(email: params[:email], password: params[:password])

    if user
      session[:user_id] = user.id
      flash[:notice] = JSON.parse(File.read('user_messages.json'))['sign_in_success']
      redirect('/posts')
    else
      flash[:notice] = JSON.parse(File.read('user_messages.json'))['invalid_login_details']
      redirect('/sessions/new')
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = JSON.parse(File.read('user_messages.json'))["sign_out_success"]
    redirect('/posts')
  end

  run! if app_file == $PROGRAM_NAME
end
