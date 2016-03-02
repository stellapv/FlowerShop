require 'bcrypt'
class LoginsController < ApplicationController
  include BCrypt
  skip_before_action :require_login, :session_expiration

  def create
    @user = User.where(email: params[:user][:email]).first

    if @user && Password.new(@user.password_digest) == params[:user][:password]
      session = Session.create(user: @user)
      cookies[:token] = session.token
      flash[:notice] = "Succesffully logged in"
      redirect_to root_path
    else
      flash[:notice] = "Wrong email or password"
      render "users/login"
    end 

  end

  def destroy
    session = Session.where(:token => cookies[:token]).first
    session.destroy!
    cookies.delete(:token)
    flash[:notice] = "Succesffully logged out"
    redirect_to root_path
  end

end
