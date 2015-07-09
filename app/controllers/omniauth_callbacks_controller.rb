class OmniauthCallbacksController < Devise::OmniauthCallbacksController
def all
	# raise request.env["omniauth.auth"].to_yaml
	user=User.from_omniauth(request.env["omniauth.auth"])
	if user.persisted?
		sign_in_and_redirect user, notice: "Signed In!!"
		user.save_friends(user)
		# redirect_to(:controller => 'welcome', :action => 'index')

	# elsif user.exist(user.uid)
	# 	current_user=user
	# 	sign_in_and_redirect user, notice: "Signed In!!"
	# 	# redirect_to(:controller => 'welcome', :action => 'index')
	else
		session["devise.user_attributes"]= user.attributes
		redirect_to new_user_registration_url
	end
end
alias_method :facebook, :all
end
