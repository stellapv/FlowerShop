class FlowersController < ApplicationController
	include ActionView::Helpers::TextHelper

	helper_method :availability?, :current_type, :all_types
	
	skip_before_action :require_login, only: [:index, :show, :search]
	skip_before_action :session_expiration, only: [:index, :show, :search]

	def index
			@flowers = Type.find(params[:type_id]).flowers.order(:name).page params[:page]
		  @order_item = OrderItem.new
	end

	def admin_index
		if current_user.admin?
			@flowers = Flower.order(:name).page params[:page]
		else
			redirect_to "/"
		end
	end

	def new
		@flower = Flower.new
	end

	def create
		@flower = Flower.new(flower_params)

		if @flower.save
			redirect_to "/flowers"
		else
			render 'new'
			flash[:error] = "fail"
		end
	end

	def edit
		@flower = Flower.find(params[:id])
	end

	def update
		@flower = Flower.find(params[:id])
		
		if @flower.update(flower_params)
			redirect_to '/flowers'
		else
			render '/edit'
			flash[:error]= "Couldn't save the changes"
		end
	end


	def show
		@flower = Flower.find(params[:id])
		@comment = Comment.new
	end

	def destroy
		@flower = Flower.find(params[:id])
		@flower.destroy
		redirect_to "/flowers"
	end


	def search
		flowers = Flower.all
  	@search_flowers = flowers.reject { |a| a unless a.name.downcase.include?(params[:q].downcase) || a.description.downcase.include?(params[:q].downcase) }
  	@search_flowers.each do |f|
  		f.name = search_and_highlight(f.name)
  		f.description = search_and_highlight(f.description)
		end
	end

	private

	def flower_params
		params.require(:flower).permit(:name, :description, :price, :quantity, :flower_photo, type_ids: [])
	end

	def availability?
		return true ? @flower.quantity > 0 : nil
	end

	def current_type
		type = Type.find(params[:type_id])
	end

	def search_and_highlight(string)
		f_attr = string.split(" ")
		f_attr.map! {|word| word.downcase.include?(params[:q].downcase) ? highlight("#{word}", "#{word}") : word }
		f_attr.join(" ")
	end

end
