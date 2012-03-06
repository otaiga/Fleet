module Foo
  class Bar
    def phonelist(current_account)
        @user = Account.find(current_account)
  		@phonelist = @user.phonelists.all
  		@phonelist.map { |list| [ list.name, list.id] }
    end
  end
end
