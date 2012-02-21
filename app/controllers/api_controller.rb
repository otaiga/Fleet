class ApiController < ApplicationController
# before_filter :http_basic_authentication
before_filter :get_inbound_calls
before_filter :get_outbound_calls
before_filter :get_inbound_sms
before_filter :get_outbound_sms

  def index
    @policy = Account.find(1).policies.last
    @all = ["Policy Name" => @policy.name, "Settings" => {"Lock Settings" => @policy.lock,  "Lock Pin" => @policy.lock_pin, "inbound calls" => @inboundCalls, "oubound calls" => @outboundCalls, "inbound sms" => @inboundSMS, "oubound sms" => @outboundSMS}]
    respond_to do |format|
      format.xml { render :xml => @all.to_xml }
      format.html { redirect_to root_path }
      format.json { render :json => @all.to_json }
    end
  end


  protected

    def http_basic_authentication
      @username = Group.where(:account_id => 1).first.name
      @password = Group.where(:account_id => 1).last.name
      if request.format == Mime::XML
        authenticate_or_request_with_http_basic do |username, password|
        username == @username && password == @password
        end
      end
    end



    def get_inbound_calls
      @inboundCalls =[]
      @policy_id = Account.find(1).policies.last.id
      @calls_inbound = CallsInboundMsisdn.where(:policy_id => @policy_id)
      @calls_inbound.each do |inboundCalls|
      @inboundCalls << inboundCalls.msisdn
      end
    end

    def get_outbound_calls
      @outboundCalls =[]
      @policy_id = Account.find(1).policies.last.id
      @calls_outbound = CallsOutboundMsisdn.where(:policy_id => @policy_id)
      @calls_outbound.each do |outboundCalls|
      @outboundCalls << outboundCalls.msisdn
      end
    end

    def get_inbound_sms
      @inboundSMS =[]
      @policy_id = Account.find(1).policies.last.id
      @sms_inbound = SmsInboundMsisdn.where(:policy_id => @policy_id)
      @sms_inbound.each do |inboundSms|
      @inboundSMS << inboundSms.msisdn
      end
    end

    def get_outbound_sms
      @outboundSMS =[]
      @policy_id = Account.find(1).policies.last.id
      @sms_outbound = SmsOutboundMsisdn.where(:policy_id => @policy_id)
      @sms_outbound.each do |outboundSms|
      @outboundSMS << outboundSms.msisdn
      end
    end
  
end


