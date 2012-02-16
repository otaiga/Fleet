class PolicyController < ApplicationController
before_filter :authenticate_account!


  def index
    @policy = Policy.new
  end

  def create
  	@policy = Policy.new(params[:policy])
   
    if @policy.valid?

    Policy.create(params[:policy])
    redirect_to(root_path, :notice => "Policy was successfully created.")

    else
      flash.alert = "Please fill in all fields."
      render :policy_index
    end
  end


  def edit
  	 @user = Account.find(current_account.id)
  	 @policy = @user.policies.find(params[:format])
  	 @settings = @policies.settings.all
  end

  def destroy
  	 @profile = Policy.destroy(params[:format])
    redirect_to root_path
  end


end
