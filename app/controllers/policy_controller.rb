class PolicyController < ApplicationController
before_filter :authenticate_account!


  def index
    @policy = Policy.new
  end

  def create
  	@policy = Policy.new(params[:policy])
   
    if @policy.valid?

    Policy.create(params[:policy])
    redirect_to root_path

    else
      flash.alert = "Please fill in all fields."
      render :index
    end
  end


  def edit
  	 @user = Account.find(current_account.id)
  	 @policy = @user.policies.find(params[:format])
     
     get_inbound_calls
     get_outbound_calls
     get_inbound_sms
     get_outbound_sms
  end

  def destroy
  	@profile = Policy.destroy(params[:format])
    @groups = Account.find(current_account.id).groups.where(:policy_id => (params[:format]))
    @groups.each {|group| Group.find(group.id).update_attributes(:policy_id => nil) }
    redirect_to root_path
  end

  def append_to_group
    @policy = params[:format][0]
    @user = Account.find(current_account.id)
    @group = @user.groups.find(params[:format][1])
    @group.update_attributes(:policy_id => @policy)
    redirect_to root_path
  end


protected

    def get_inbound_calls
      @inboundCalls =[]
      @policy_id = @policy.id
      @calls_inbound = CallsInboundMsisdn.where(:policy_id => @policy_id)
      @calls_inbound.each do |inboundCalls|
      @inboundCalls << inboundCalls.msisdn
      end
    end

    def get_outbound_calls
      @outboundCalls =[]
      @policy_id = @policy.id
      @calls_outbound = CallsOutboundMsisdn.where(:policy_id => @policy_id)
      @calls_outbound.each do |outboundCalls|
      @outboundCalls << outboundCalls.msisdn
      end
    end

    def get_inbound_sms
      @inboundSMS =[]
      @policy_id = @policy.id
      @sms_inbound = SmsInboundMsisdn.where(:policy_id => @policy_id)
      @sms_inbound.each do |inboundSms|
      @inboundSMS << inboundSms.msisdn
      end
    end

    def get_outbound_sms
      @outboundSMS =[]
      @policy_id = @policy.id
      @sms_outbound = SmsOutboundMsisdn.where(:policy_id => @policy_id)
      @sms_outbound.each do |outboundSms|
      @outboundSMS << outboundSms.msisdn
      end
    end

end
