class PostsController < ApplicationController
  #GET /posts
  # list all posts 
  # posts#index
  def index
    @posts = Post.all 
  end

 #GET /posts/new
 # show a new post form 
 # posts#create
 def new
  @post = Post.new
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
      # redirect_to :back, notice: "Post has been created"
    else
      flash[:error] = "Error creating post."
      render '/posts/new'
    end
  end

  #GET /posts/:id
  # show a single post
  # posts#show
  def show 
    @post = Post.find(params[:id])
  end

  #GET /posts/:id/edit
  # show an edit post form
  # need authorization
  def edit
    @post = Post.find(params[:id])
  end

  #PUT /posts/:id
  # update a post
  # need authorization
  # posts#update
  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = "Post updated."
      redirect_to '/posts'
    else
      flash[:notice] = "Hey, there was an error creating your post. Try again."
    end
  end

  # DELETE /posts/:id
  # delete a tweet
  # need authorization
  # posts#destroy
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post deleted."
    redirect_to posts_path
  end

  def current_user
    if session[:user_id]
        User.find(session[:user_id])
    end
  end
  
  def user_logged_in
    if session[:user_id]
      flash[:notice] = "Welcome!"
    else redirect_to '/'
      flash[:notice] = "This is not your account to edit."
    end
  end

  private 
  
  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
