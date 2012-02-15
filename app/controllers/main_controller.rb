class MainController < ApplicationController
before_filter :authenticate_account!

  def Index
  	@user = Account.find(current_account.id)
  end

  def create
  	@device = Device.new(params[:device])
   
    if @device.valid?

    Device.create(params[:device])
    redirect_to(root_path, :notice => "Message was successfully sent.")

    else
      flash.alert = "Please fill in all fields."
      render :new_device_create
    end
  end
  
  def new_device_create
   @device = Device.new
  end

end
