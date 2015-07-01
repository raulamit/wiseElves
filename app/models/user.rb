class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :provider, :uid
    def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid,email: auth.info.email, birthday: auth.extra.raw_info.birthday).first_or_create do |user|
  		user.provider=auth.provider
  		user.uid=auth.uid
  		user.email=auth.info.email
  		user.birthday=auth.extra.raw_info.birthday
  		# user.save
  	end
  end

  def self.new_with_session(params,session)
  	if session["devise.user_attributes"]
  		new(session["devise.user_attributes"],without_protection: true) do |user|
	 		user.attributes=params
	 		user.valid?
 		end
 	else
 		super
 	end
  end

  def password_required?
  	super &&provider.blank?
  end

  #    def user_params
  #   params.require(:user).permit(:provider, :uid)
  # end
end