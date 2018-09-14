class UsersController < ApplicationController
#GET /users
# users#index
  def index
    @users = User.all
  end

# POST /users 
# users#create
def create
  user = User.create(user_params)
  flash[:notice] = "User created."
  redirect_to user
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
    user.update(user_params)
    flash[:notice] = "User updated."
    redirect_to user
  end

  #DELETE /users/:id
  # users#destroy
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted."
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
