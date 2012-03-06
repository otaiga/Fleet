class PhoneListController < ApplicationController
before_filter :authenticate_account!


  def show
    @phonelist = Phonelist.new
  end

  def create
  	 @phonelist = Phonelist.new(params[:phonelist]) ||  @phonelist = Phonelist.new(:name => params[:name], :account_id => params[:account_id])
   
    if @phonelist.valid?

    if params[:phonelist] == nil
      Phonelist.create(:name => params[:name], :account_id => params[:account_id])     
      respond_to do |format|
        format.html {  redirect_to root_path }
        format.js
  end
    else
      Phonelist.create(params[:phonelist])
      redirect_to root_path

    end


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
    @inboundcalls = CallsInboundMsisdn.where(:phonelist_id => (params[:format]))

    @inboundcalls.each { |inboundcalls|
      CallsInboundMsisdn.destroy(inboundcalls.id)
    }

   
    @outboundcalls = CallsOutboundMsisdn.where(:phonelist_id => (params[:format]))

    @outboundcalls.each { |outboundcalls|
      CallsOutboundMsisdn.destroy(outboundcalls.id)
    }


    @inboundsms = SmsInboundMsisdn.where(:phonelist_id => (params[:format]))

    @inboundsms.each { |inboundsms|
      SmsInboundMsisdn.destroy(inboundsms.id)
    }


    @outboundsms = SmsOutboundMsisdn.where(:phonelist_id => (params[:format]))

    @outboundsms.each { |outboundsms|
      SmsOutboundMsisdn.destroy(outboundsms.id)
    }



    
    @phonelist = Phonelist.destroy(params[:format])
    redirect_to root_path
  end


end
