class OrdersController < ApplicationController
	include Chartkick::Helper
	
	def index
		if current_user.admin?
			@orders = Order.all
		else
			@orders = User.where(id: current_user.id).first.orders
		end		
	end

	def create
		@order = Order.new()
		
		if @order.save
			redirect_to "/orders"
		else
			render "/carts/show"
		end
	end

	def destroy
		if current_order.id == params[:id].to_i
			current_order.destroy
			redirect_to "/"
		else
			flash[:error] = "Cant delete"
			redirect_to "/carts/show"
		end
	end

	def finish
		if current_order.id == params[:id].to_i && !params[:order][:address].empty? && delivery_date_in_future?
			current_order.address = params[:order][:address]
			current_order.delivery_date = date_param
			current_order.update(order_params)
		
			current_order.finish!
			flash[:notice] = "Your order is being proccessed"
			redirect_to "/orders/payment"
		else
			flash[:notice] = "There's a problem - maybe a blank address field or past delivery date? The order can't be finished!"
			render "/carts/show"
		end

	end
	
	def cancel
		if !current_user.admin?
			redirect_to "/"
		else
			Order.find(params[:id]).cancel!
		end

		redirect_to "/orders"
	end

	def complete
		if !current_user.admin?
			redirect_to "/"
		else
			Order.find(params[:id]).deliver!
		end

		redirect_to "/orders"
	end

	def payment
		render :layout => false
		@order = Order.where(user: current_user, state: "confirmed").first
	end

	def pay
		if current_order.confirmed?
			current_order.pay!
			flash[:notice] = "Transaction created"
			redirect_to "/"
		else
			flash[:notice] = "You have to finish your order first"
			render "carts/show"
		end
	end

	private

		def order_params
			params.require(:order).permit(:user_id, :total, :state, :address, :delivery_date)
		end

		def date_param
			date = Date.civil(params[:order]["delivery_date(1i)"].to_i,params[:order]["delivery_date(2i)"].to_i,params[:order]["delivery_date(3i)"].to_i)
		end

		def delivery_date_in_future?
			date_param > Date.today
		end

end
