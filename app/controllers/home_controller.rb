class HomeController < ApplicationController
	def dashboard
		@user_name_props = { name: current_user.full_name }
		@managed_teams = current_user.managed_teams
	end	
end