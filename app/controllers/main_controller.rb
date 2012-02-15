class MainController < ApplicationController
before_filter :authenticate_account!

  def Index
  	@user = Account.find(current_account.id)
  end


  def about

  end


  def terms

  end

  def support

  end
end
