require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/posts'
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.create(params[:post])
    redirect "/posts"
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/' do
    redirect '/posts'
  end

  get '/posts/:id' do
    begin
      @post = Post.find(params[:id])
      erb :show
    rescue
      status 404
      erb :not_found
    end
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(params[:post])
    # binding.pry
    erb :show
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    Post.find(params[:id]).destroy
    erb :delete
  end
end
