module MainHelper
  def flash_class(level)
    case level
      when :notice then "info"
      when :error then "error"
      when :alert then "warning"
    end
  end

  def device_form
    @user = Account.find(current_account.id)
    @groups = @user.groups.all
    @groups.map { |group| [group.name, group.id] }
  end
end
