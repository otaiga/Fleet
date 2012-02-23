class ApiController < ApplicationController
# before_filter :http_basic_authentication
before_filter :get_inbound_calls
before_filter :get_outbound_calls
before_filter :get_inbound_sms
before_filter :get_outbound_sms

  def index
    @params = params[:msisdn]

    get_mobile
    unless @member.count == 0
    @policy = Policy.find(@memberpolicy)
    @all = ["Policy Name" => @policy.name, "Settings" => {"Lock Settings" => @policy.lock,  "Lock Pin" => @policy.lock_pin, "Voice" => @policy.voice, "Messaging" => @policy.messaging, "Maps" => @policy.maps, "Phonebook" => @policy.phonebook, "Browsing" => @policy.browsing, "Notes" => @policy.notes}, "NumberList" => {"inbound calls" => @inboundCalls, "oubound calls" => @outboundCalls, "inbound sms" => @inboundSMS, "oubound sms" => @outboundSMS}]
    respond_to do |format|
      format.xml { render :xml => @all.to_xml }
      format.html { render :json => @all.to_json }
      format.json { render :json => @all.to_json }
    end
    else
     @all = ["Error - no msisdn found"]
     respond_to do |format|
      format.xml { render :xml => @all.to_xml }
      format.html { render :json => @all.to_json }
      format.json { render :json => @all.to_json }
    end
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


    def get_mobile
      @mobile = Group.all.each { |group|
      @member = group.devices.where(:msisdn => @params)
        if @member.count == 0
           return
        else
          @memberpolicy = Group.find(@member.last.group_id).policy_id
        end
      }
    end

   def get_inbound_calls
      @inboundCalls ={}
      @policy_id = Account.find(1).policies.last.id
      @policy= Policy.find(@policy_id)

      @phonelist_ids = []
      @policy.calls_inbound_msisdns.each { |phoneId| 
      @phonelist_ids << phoneId.phonelist_id
        }
      @phonelist_ids.each {|phoneID|
      Phonelist.find(phoneID).lists.each { |contact|
      @inboundCalls[contact.member] = contact.msisdn
        }
      }
    end

    def get_outbound_calls
      @outboundCalls ={}
      @policy_id = Account.find(1).policies.last.id
      @policy= Policy.find(@policy_id)


      @phonelist_ids = []
      @policy.calls_outbound_msisdns.each { |phoneId| 
      @phonelist_ids << phoneId.phonelist_id
        }
      @phonelist_ids.each {|phoneID|
      Phonelist.find(phoneID).lists.each { |contact|
      @outboundCalls[contact.member] = contact.msisdn
      }
    }
    end

    def get_inbound_sms
      @inboundSMS ={}
      @policy_id = Account.find(1).policies.last.id
      @policy= Policy.find(@policy_id)


      @phonelist_ids = []
      @policy.sms_inbound_msisdns.each { |phoneId| 
      @phonelist_ids << phoneId.phonelist_id
        }
      @phonelist_ids.each {|phoneID|
      Phonelist.find(phoneID).lists.each { |contact|
      @inboundSMS[contact.member] = contact.msisdn
      }
    }
    end

    def get_outbound_sms
      @outboundSMS ={}
      @policy_id = Account.find(1).policies.last.id
      @policy= Policy.find(@policy_id)


      @phonelist_ids = []
      @policy.sms_outbound_msisdns.each { |phoneId| 
      @phonelist_ids << phoneId.phonelist_id
        }
      @phonelist_ids.each {|phoneID|
      Phonelist.find(phoneID).lists.each { |contact|
      @outboundSMS[contact.member] = contact.msisdn
      }
    }
    end

  
end


