class BetaPagesController < ApplicationController
	layout 'beta'
	
	#before_filter :check_login
	
	def check_login
		redirect_to '/login' if not user_signed_in?
	end

end
