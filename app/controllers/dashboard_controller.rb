class DashboardController < ApplicationController
	def index
	end

	def show
		@search_user=User.find(params[:id])
		if (@search_user==current_user)
			redirect_to(:controller => 'welcome', :action => 'index')
		end
	end
end
