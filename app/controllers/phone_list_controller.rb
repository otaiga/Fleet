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
  end

  def destroy
    @phonelist = Phonelist.destroy(params[:format])
    redirect_to root_path
  end


end
