class MainController < ApplicationController
before_filter :authenticate_account!

  def Index
  	@user = Account.find(current_account.id)
  end

  def create
  	@device = Device.new(params[:device])
   
    if @device.valid?

    Device.create(params[:device])
    redirect_to(root_path, :notice => "Device was successfully created.")

    else
      flash.alert = "Please fill in all fields."
      render :new_device_create
    end
  end
  
  def new_device_create
   @device = Device.new
  end

  def new_group_create
    @group = Group.new
  end

  def create_group
    @group = Group.new(params[:group])
   
    if @group.valid?

    Group.create(params[:group])
    redirect_to(root_path, :notice => "Group was successfully created.")

    else
      flash.alert = "Please fill in all fields."
      render :new_group_create
    end
  end

end
