class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = current_user
    @users = User.all
    @new_book = Book.new
  end

  def show
    @new_book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @edit_user = User.find(params[:id])
    if @edit_user != current_user
      @user = current_user
      @users = User.all
      render :index
    end
  end

  def update
    @edit_user = User.find(params[:id])
    if @edit_user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@edit_user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if (user_id != login_user_id )
      redirect_to user_path(current_user.id)
    end
  end

end
