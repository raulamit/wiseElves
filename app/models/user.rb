class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_many :friendships, :foreign_key => "user_id", :dependent => :destroy
  # has_many :occurances_as_friend, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_and_belongs_to_many(:users,
    :join_table => "friendships",
    :foreign_key => "user_id",
    :association_foreign_key => "friend_id")

  has_many :campaigns_for, :class_name=> "Campaign", foreign_key: "beneficiary_id"
  has_many :campaigns_by, :class_name=> "Campaign", foreign_key: "campaigner_id"
  has_many :contributions

  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :provider, :uid
    def self.from_omniauth(auth)

  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  		user.provider=auth.provider
  		user.uid=auth.uid
  		user.email=auth.info.email
  		user.birthday=auth.extra.raw_info.birthday
  		user.oauth_token= auth.credentials.token
  	 	user.oauth_expires_at= auth.credentials.outh_expires_at
  	 	user.image_url=auth.info.image
  	 	user.name= auth.info.name
  	 	# user.save_friends(user)
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

  def facebook
  	@facebook ||=Koala::Facebook::API.new(oauth_token)
  end

  def exist(id)
  	@exist=!User.where(uid: id).empty?
  end

  def save_friends(user)
  	userFriendHash=user.facebook.get_connection("me","friends")
  	if(user.users.size!=userFriendHash.size)
	  	userFriendHash.each do |u|
	  		tempID =u.fetch("id")
	  		if (user.users.where(uid: tempID).empty?)
	  			user.users<<User.where(uid: u.fetch("id"))
	  		end

	  	end
	  	user.save
	end
  end
  #    def user_params
  #   params.require(:user).permit(:provider, :uid)
  # end
end