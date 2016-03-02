class OrderItemsController < ApplicationController

	def create
		if current_order.confirmed?
			redirect_to "/orders/payment" and return
		end
		@order = current_order
		create_order_item

		if @order.save
			redirect_to "/carts/show"
		else
			flash[:error] = "Error adding flower to cart"
			redirect_to "/"
		end
		
	end

	def update
		@order = current_order
		@order_item = @order.order_items.find(params[:id])
		@order_item.update_attributes(order_item_params)
		@order_items = @order.order_items
	end

	def destroy
		@order = current_order
		@order_item = @order.order_items.find(params[:id])
		
		increase_flower_quantity

		@order_item.destroy
		@order_items = @order.order_items
		
		if @order_items.empty?
			@order.destroy
			redirect_to "/"
		else
			@order.calculate_total
			@order.save
			redirect_to "/carts/show"
		end

	end

	private

		def order_item_params
			params.require(:order_item).permit(:quantity, :flower_id, :order)
		end

		def create_order_item
			order_item = OrderItem.where(order: current_order, flower: Flower.find(order_item_params[:flower_id])).first
			if order_item
				@order_item = order_item
				@order_item.quantity += order_item_params[:quantity].to_i
				@order_item.subtotal = @order_item.quantity * @order_item.unit_price
			else
				@order_item = OrderItem.new(order_item_params)
				@order_item.order = current_order
				@order_item.unit_price  = Flower.find(order_item_params[:flower_id]).price
				@order_item.subtotal = @order_item.quantity * @order_item.unit_price
				@order.order_items << @order_item
			end

			decrease_flower_quantity

		end

		def increase_flower_quantity
			flower = @order_item.flower
			flower.quantity += @order_item.quantity
			flower.save
		end

		def decrease_flower_quantity
			flower = Flower.find(order_item_params[:flower_id])
			flower.quantity -= order_item_params[:quantity].to_i
			flower.save
		end
		
end
