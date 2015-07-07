class Contribution < ActiveRecord::Base
	belongs_to :contributor, :class_name => "User", :foreign_key=> "user_id"
	belongs_to :campaign
end
