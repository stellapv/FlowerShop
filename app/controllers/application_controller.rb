class ApplicationController < ActionController::Base

  helper_method :current_user, :current_order, :all_types
  before_action :load_menu, :session_expiration, :require_login

  private

  def load_menu
    @occasion_types = Type.where(dropdown: "occasion")
    @plant_types = Type.where(dropdown: "plant")
    @flower_types = Type.where(dropdown: "flower")
  end

  def current_user
    if cookies[:token]
      sessions_array = Session.where(token: cookies[:token])
      if sessions_array.any?
        sessions_array.first.user
      end
    end
  end

  def session_expiration
    if current_user
      session = current_user.session
      if session.expires_at < Time.now
        session.destroy
      end
    end
  end

  def require_login
   if current_user.nil?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path and return
    end
  end

  def current_order
    Order.where(user: current_user).where("state = 'created' or state = 'confirmed'").first || 
    Order.new(user: current_user, state: "created")
  end

  def all_types
    types = Type.all
  end
  
end
