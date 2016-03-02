class ChartsController < ApplicationController
  before_action :orders_by_state, :orders_by_creation, 
    :users_by_creation, :flowers_by_types, :orders_by_total, :flowers_by_price, 

  def orders_by_state
    @o_by_state = Order.group(:state).count
  end

  def orders_by_creation
    @o_by_create = Order.group_by_week(:created_at).count
  end

  def orders_by_total
    @o_by_total = Order.group(:total).count
  end

  def flowers_by_types
    @f_by_types = Flower.joins(:types).group("types.dropdown").count
  end

  def flowers_by_price
    @f_by_price = Flower.group(:price).count
  end

  def users_by_creation
    @u_by_create = User.group_by_day(:created_at).count
  end

end