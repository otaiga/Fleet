module PhoneListHelper
  def phonelist_form
    @user = Account.find(current_account.id)
    @phonelist = @user.phonelists.all
    @phonelist.map { |list| [list.name, list.id] }
  end

end
