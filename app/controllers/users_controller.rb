require 'bcrypt'

class UsersController < ApplicationController
	include BCrypt
	skip_before_action :require_login, only: [:login, :new, :create]
	skip_before_action :session_expiration, only: [:login, :new, :create]
	
	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		@user.password_digest = Password.create(params[:user][:password], cost: 11)

		if @user.save
			redirect_to root_path
			flash[:notice] = "Successfully signed up!"
		else
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to root_path
			flash[:notice] = "Data successfully changed"
		else
			render 'edit'
		end
	end

	private

	def user_params
		params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
	end
end
