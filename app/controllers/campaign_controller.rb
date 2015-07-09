class CampaignController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  	campaign= Campaign.new(:original_amount_pledged => params[:original_amount_pledged],
  		:amount_contributed => params[:amount_contributed],
  		:start_date=> Date.today,
  		:status=> :active,
  		)
  	puts Date.today
  	 contribution =Contribution.new(:amount => params[:amount_contributed])

  	beneficiary_user=User.find(params[:id])
  	campaign.beneficiary=beneficiary_user
  	campaign.campaigner=current_user

  	contribution.contributor=current_user
  	contribution.campaign=campaign
  	contribution.save
  	campaign.save
  	redirect_to(:controller => 'dashboard', :action => 'show')
  end

  def show
  end

  def stop
  end

  def edit
  end
end
