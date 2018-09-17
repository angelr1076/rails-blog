class UsersController < ApplicationController
#GET /users
# users#index
def index
  @users = User.all
end

def your_account
  user_logged_in
  @current_user = current_user
end

# POST /users 
# users#create
def create
  user = User.new(user_params)
  if user.save
  flash[:notice] = "User created."
  redirect_to user
  else
    flash[:notice] = "There was an error. "
    flash[:notice] += user.errors.full_messages.join(', ')
    redirect_to new_user_path
  end
end

  # GET /users/new
  # users#new
  def new
    @user = User.new
  end

   # GET /users/:id/edit
  # users#edit
  def edit
    @user = User.find(params[:id])
    # render posts_path
  end

  #GET /users/:id
  # users#show
  def show 
    @user = User.find(params[:id])
  end

  #PUT /users/:id
  # users#update
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "User updated."
      redirect_to user
    else
      flash[:notice] = "Update failed. "
      flash[:notice]  += user.errors.full_messages.join(', ')
      redirect_to edit_user_path(user)
      # redirect_to_fallback()
      # redirect_back(fallback_location: root_path)
  end
end

  #DELETE /users/:id
  # users#destroy
  def destroy
      @user = User.find(params[:id])
      # Destroy all posts and comments. If this isn't attached, 
      # checking posts belonging to deleted users breaks the session
      @user.posts.each do |post|
      @user.comments.destroy_all
      @user.posts.destroy_all
      @user.destroy
      session[:user_id] = nil
    flash[:notice] = "User deleted."
    redirect_to users_path
  end
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

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
