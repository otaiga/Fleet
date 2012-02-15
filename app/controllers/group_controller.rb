class GroupController < ApplicationController
before_filter :authenticate_account!


  def edit
  	 @user = Account.find(current_account.id)
  	 @group = @user.groups.find(params[:format])
  	 @devices = @group.devices.all
  end

  def destroy
  	 @group = Group.destroy(params[:format])
    redirect_to root_path
  end
end
