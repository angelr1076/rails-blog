class CommentsController < ApplicationController

  def index
    @comment = Comment.all 
  end

  def new
    user = session[:user_id]
    @comment = Comment.new(post_id: params[:post_id])
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = session[:user_id]
    @postid = params[:id]
    if @comment.save
      flash[:notice] = "comment created."
      redirect_to '/posts'
    else
      flash[:error] = "Error creating comment."
      redirect_to '/posts'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find_by_id(params[:id])
    @comment.update(comment_params)
    flash[:notice] = "Comment updated."
    redirect_to '/posts'
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to '/posts'
  end

  def check_auth
    if session[:user_id] != @post.user_id
      flash[:notice] = "You can't edit this comment"
      redirect_to posts_path
  end
end

  private 
  
    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
  end
  
