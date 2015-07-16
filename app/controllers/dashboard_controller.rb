class DashboardController < ApplicationController
	# layout "dashboard_layout"
	def index
		# if	user_signed_in?
		# else
		# 	redirect_to root_path, notice: "Please sign In!!"
		# end
	end

	def show
		@search_user=User.find(params[:id])
		if (@search_user==current_user)
			redirect_to(:controller => 'welcome', :action => 'index')
		end
	end
end
