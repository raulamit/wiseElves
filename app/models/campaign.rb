class Campaign < ActiveRecord::Base
	enum status: [ :active, :closed ,:successful, :failed]

	belongs_to :campaigner, class_name: "User", foreign_key: "campaigner_id"
	belongs_to :beneficiary, class_name: "User", foreign_key: "beneficiary_id"
	has_many :contributions
end
