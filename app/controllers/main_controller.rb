class MainController < ApplicationController
before_filter :authenticate_account!

  def Index
  	@user = Account.find(current_account.id)
  end
  
end
