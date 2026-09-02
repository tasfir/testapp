class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.order(:name)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params_for_update)
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to users_path, alert: "You can't delete your own account while signed in as it."
      return
    end

    @user.destroy
    redirect_to users_path, status: :see_other, notice: "User was successfully deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # On update, don't touch the password at all unless the admin actually typed a new one.
  def user_params_for_update
    permitted = user_params
    permitted[:password].blank? ? permitted.except(:password, :password_confirmation) : permitted
  end
end
