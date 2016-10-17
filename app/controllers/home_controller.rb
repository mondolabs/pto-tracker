class HomeController < ApplicationController

	def dashboard
		@user_name = current_user.full_name
	end

end