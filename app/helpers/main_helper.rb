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

  def policy(group)
     @policy = Group.find(group).policy_id
     unless @policy != nil
      "No Policy Selected"
    else
      @policy_name = Policy.find(@policy)
      "#{@policy_name.name}"
    end
  end

  def device_name(device)
    @name = device.name
    if @name == "" || nil
      "-"
    else
      "#{device.name}"
    end
  end
end
