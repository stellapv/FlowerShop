class WelcomeController < ApplicationController
	skip_before_action :require_login, :session_expiration
end
