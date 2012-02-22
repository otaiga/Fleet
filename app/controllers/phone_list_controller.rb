class PhoneListController < ApplicationController
before_filter :authenticate_account!


  def show
    @phonelist = Phonelist.new
  end

  def create
  	 @phonelist = Phonelist.new(params[:phonelist])
   
    if @phonelist.valid?

    Phonelist.create(params[:phonelist])
    redirect_to root_path

    else
      flash.alert = "Please fill in all fields."
      render :show
    end
  end

  def edit
  	 @phonelist = Phonelist.find(params[:format])
     @list = Phonelist.find(params[:format]).lists
     @newlist = List.new
  end


  def destroy_list_item
     @phonelistid = params[:format][0]
     @listid = params[:format][1]

     Phonelist.find(@phonelistid)
     List.destroy(@listid)
     redirect_to phone_list_edit_path(@phonelistid)

  end


  def create_list_item  
    List.create(:member => params["list"]["member"], :msisdn => params["list"]["msisdn"], :phonelist_id => params["list"]["phonelist_id"])

    @phonelistid = params["list"]["phonelist_id"]
    redirect_to phone_list_edit_path(@phonelistid)
  end



  def destroy
    @phonelist = Phonelist.destroy(params[:format])
    redirect_to root_path
  end


end
