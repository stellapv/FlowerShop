class TypesController < ApplicationController

	def new
		@type = Type.new
	end

	def create
		@type = Type.new(type_params)
		
		if @type.save
			redirect_to "/types"
			flash[:notice] = "Successfully created!"
		else
			render 'new'
		end
		
	end

	def destroy
		@type = Type.find(params[:id])
		@type.destroy
		redirect_to "/types"
	end

	def show
		@types = Type.find[params[:id]]
	end

	def edit
		@type = Type.find(params[:id])
	end

	def update
		@type = Type.find(params[:id])
		if @type.update(type_params)
			redirect_to "/types/index"
		end
	end

	def index
		if !current_user.admin?
			redirect_to "/"
		end

		@types = Type.all
	end

	private

		def type_params
			params.require(:type).permit(:name, :dropdown)
		end
		
end
