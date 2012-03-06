module PolicyHelper
	
  def phonelist
    @user = Account.find(current_account.id)
    @phonelist = @user.phonelists.all
    if @phonelist != nil
  	  @phonelist.map { |list| [ list.name, list.id] }
  	else
  	  return nil
  	end

  end



  def phonelist_id(listid)
    @name = Phonelist.find(listid).name

  end
end
