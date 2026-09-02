class ProfilesController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if params[:user][:password].present? && !@user.authenticate(params[:user][:current_password])
      @user.errors.add(:base, "Current password is incorrect")
      return render :edit, status: :unprocessable_entity
    end

    if @user.update(profile_params)
      redirect_to profile_path, notice: "Profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  # On update, don't touch the password at all unless a new one was actually typed.
  def profile_params
    permitted = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    permitted[:password].blank? ? permitted.except(:password, :password_confirmation) : permitted
  end
end
