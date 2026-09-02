class SessionsController < ApplicationController
  layout "auth"
  skip_before_action :require_login
  before_action :redirect_if_logged_in, only: :new

  def new
  end

  def create
    user = User.find_by(email: params[:email]&.downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Signed out."
  end

  private

  def redirect_if_logged_in
    redirect_to root_path if logged_in?
  end
end
