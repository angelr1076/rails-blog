class CommentsController < ApplicationController

  def index
    @comments = Comment.all 
  end

  def create
    @comment = Comment.create(comment_params)
    @comment.user_id = session[:user_id]
    if @comment.save
      flash[:notice] = "commment created."
      redirect_to '/posts'
    else
      flash[:error] = "Error creating comment."
      redirect_to '/posts'
    end
  end

  def new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def show 
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    flash[:notice] = "Comment updated."
    redirect_to '/posts'
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "Comment deleted."
    redirect_to posts_path
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
