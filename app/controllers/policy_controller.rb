class PolicyController < ApplicationController
before_filter :authenticate_account!


  def index
    @policy = Policy.new
    @policy.calls_inbound_msisdns.build

  end

  def create
  	@policy = Policy.new(params[:policy])
   
    if @policy.valid?

    Policy.create(params[:policy])
    redirect_to root_path

    else
      flash.alert = "Please fill in all fields."
      render :index
    end
  end


  def edit
  	 @user = Account.find(current_account.id)
  	 @policy = @user.policies.find(params[:format])
  end

  def destroy
  	@profile = Policy.destroy(params[:format])
    @groups = Account.find(current_account.id).groups.where(:policy_id => (params[:format]))
    @groups.each {|group| Group.find(group.id).update_attributes(:policy_id => nil) }
    redirect_to root_path
  end

  def append_to_group
    @policy = params[:format][0]
    @user = Account.find(current_account.id)
    @group = @user.groups.find(params[:format][1])
    @group.update_attributes(:policy_id => @policy)
    redirect_to root_path
  end


end
