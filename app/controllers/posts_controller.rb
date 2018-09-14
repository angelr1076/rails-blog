class PostsController < ApplicationController
  #GET /posts
  # list all posts 
  # posts#index
  def index
    @posts = Post.all 
  end

#POST /posts
  # create a new post 
  # posts#create
  def create
    @post = Post.create(post_params)
    @post.user_id = session[:user_id]
    if @post.save
      flash[:notice] = "Post created."
      redirect_to '/posts'
    else
      flash[:error] = "Error creating post."
      render '/posts/new'
    end
  end

 #GET /posts/new
 # show a new post form 
 # posts#create
  def new
    @post = Post.new
  end

  #GET /posts/:id
  # show a single post
  # posts#show
  def show 
    @post = Post.find(params[:id])
  end

  #PUT /posts/:id
  # update a post
  # need authorization
  # posts#update
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "Post updated."
    redirect_to '/posts'
  end

  #GET /posts/:id/edit
  # show an edit post form
  # need authorization
  def edit
    @post = Post.find(params[:id])
  end

  # DELETE /posts/:id
  # delete a tweet
  # need authorization
  # posts#destroy
  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "Post deleted."
    redirect_to posts_path
  end

  def check_auth
    if session[:user_id] != @post.user_id
      flash[:notice] = "You can't edit this post"
      redirect_to posts_path
  end
end

  private 
  
  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
