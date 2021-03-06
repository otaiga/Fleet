class PolicyController < ApplicationController
before_filter :authenticate_account!


  def index
    @policy = Policy.new
    @phonelist = Phonelist.new
  end

  def create
  	@policy = Policy.new(params[:policy])
   
    if @policy.valid?

    @policy.save
    redirect_to policy_next_path(@policy.id)

    else
      flash.alert = "Please fill in all fields."
      render :index
    end
  end

  def updatesettings
    @policy = Policy.find(params[:policy][:id])
    @policy.update_attributes(:notes=>params[:policy][:notes], :messaging=>params[:policy][:messaging], :phonebook=>params[:policy][:phonebook], :maps=>params[:policy][:maps], :browsing=>params[:policy][:browsing], :voice=>params[:policy][:voice])
    redirect_to policy_edit_path(params[:policy][:id])
  end

  def updatelock
    @policy = Policy.find(params[:policy][:id])
    @policy.update_attributes(:lock=>params[:policy][:lock], :lock_pin=>params[:policy][:lock_pin])
    redirect_to policy_edit_path(params[:policy][:id])
  end




#Removes the callists ..
  def updatecallinbound
    @policy_id = params[:format][0]
    @phonelist_id = params[:format][1]
    @policy = Policy.find(@policy_id)
    @inboundremove = @policy.calls_inbound_msisdns.where(:phonelist_id => @phonelist_id)
    CallsInboundMsisdn.destroy(@inboundremove.last.id)

    unless params[:format][2] !=nil
      redirect_to policy_edit_path(params[:format][0])
    else
      redirect_to policy_next_path(params[:format][0])
    end
  end

  def updatecalloutbound
    @policy_id = params[:format][0]
    @phonelist_id = params[:format][1]
    @policy = Policy.find(@policy_id)
    @outboundremove = @policy.calls_outbound_msisdns.where(:phonelist_id => @phonelist_id)
    CallsOutboundMsisdn.destroy(@outboundremove.last.id)
    
    unless params[:format][2] !=nil
      redirect_to policy_edit_path(params[:format][0])
    else
      redirect_to policy_next_path(params[:format][0])
    end
  end



  def updatesmsinbound
    @policy_id = params[:format][0]
    @phonelist_id = params[:format][1]
    @policy = Policy.find(@policy_id)
    @smsinboundremove = @policy.sms_inbound_msisdns.where(:phonelist_id => @phonelist_id)
    SmsInboundMsisdn.destroy(@smsinboundremove.last.id)
    
    unless params[:format][2] !=nil
      redirect_to policy_edit_path(params[:format][0])
    else
      redirect_to policy_next_path(params[:format][0])
    end
  end

  def updatesmsoutbound
    @policy_id = params[:format][0]
    @phonelist_id = params[:format][1]
    @policy = Policy.find(@policy_id)
    @smsoutboundremove = @policy.sms_outbound_msisdns.where(:phonelist_id => @phonelist_id)
    SmsOutboundMsisdn.destroy(@smsoutboundremove.last.id)
    
    unless params[:format][2] !=nil
      redirect_to policy_edit_path(params[:format][0])
    else
      redirect_to policy_next_path(params[:format][0])
    end
  end




#adds the call lists
  def updateaddcallinbound
    @policy_id = params[:policy][:id]
    @phonelist_id = params[:policy][:phonelist_id]
    @policy = Policy.find(@policy_id)
    CallsInboundMsisdn.create(:policy_id =>@policy_id, :phonelist_id => @phonelist_id)

    unless params[:format] != nil
      redirect_to policy_edit_path(params[:policy][:id])
    else
      redirect_to policy_next_path(params[:policy][:id])
    end
  end

  def updateaddcalloutbound
    @policy_id = params[:policy][:id]
    @phonelist_id = params[:policy][:phonelist_id]
    @policy = Policy.find(@policy_id)
    CallsOutboundMsisdn.create(:policy_id =>@policy_id, :phonelist_id => @phonelist_id)
    
    unless params[:format] != nil
      redirect_to policy_edit_path(params[:policy][:id])
    else
      redirect_to policy_next_path(params[:policy][:id])
    end
  end



  def updateaddsmsinbound
    @policy_id = params[:policy][:id]
    @phonelist_id = params[:policy][:phonelist_id]
    @policy = Policy.find(@policy_id)
    SmsInboundMsisdn.create(:policy_id =>@policy_id, :phonelist_id => @phonelist_id)
    
    unless params[:format] != nil
      redirect_to policy_edit_path(params[:policy][:id])
    else
      redirect_to policy_next_path(params[:policy][:id])
    end
  end

  def updateaddsmsoutbound
    @policy_id = params[:policy][:id]
    @phonelist_id = params[:policy][:phonelist_id]
    @policy = Policy.find(@policy_id)
    SmsOutboundMsisdn.create(:policy_id =>@policy_id, :phonelist_id => @phonelist_id)
    
    unless params[:format] != nil
      redirect_to policy_edit_path(params[:policy][:id])
    else
      redirect_to policy_next_path(params[:policy][:id])
    end
  end



  def next
     @user = Account.find(current_account.id)
     @policy = @user.policies.find(params[:format])
     
     get_inbound_calls
     get_outbound_calls
     get_inbound_sms
     get_outbound_sms
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
      @inboundCalls ={}
      @policy_id = @policy.id

      @inboundCallsphonelist_ids = []
      @policy.calls_inbound_msisdns.each { |phoneId| 
      @inboundCallsphonelist_ids << phoneId.phonelist_id
        }
      unless @inboundCallsphonelist_ids == nil
        @inboundCallsphonelist_ids.each {|phoneID|
        unless Phonelist.where(:id => phoneID) == []
        Phonelist.find(phoneID).lists.each { |contact|
        @inboundCalls[contact.member] = contact.msisdn
          }
        end
        }
      end
    end

    def get_outbound_calls
      @outboundCalls ={}
      @policy_id = @policy.id


      @outboundCallsphonelist_ids = []
      @policy.calls_outbound_msisdns.each { |phoneId| 
      @outboundCallsphonelist_ids << phoneId.phonelist_id
        }
      unless @outboundCallsphonelist_ids == nil
        @outboundCallsphonelist_ids.each {|phoneID|
        unless Phonelist.where(:id => phoneID) == []
          Phonelist.find(phoneID).lists.each { |contact|
          @outboundCalls[contact.member] = contact.msisdn
            }
          end
          }
      end
    end

    def get_inbound_sms
      @inboundSMS ={}
      @policy_id = @policy.id


      @inboundSMSphonelist_ids = []
      @policy.sms_inbound_msisdns.each { |phoneId| 
      @inboundSMSphonelist_ids << phoneId.phonelist_id
        }
      unless @inboundSMSphonelist_ids == nil
        @inboundSMSphonelist_ids.each {|phoneID|
        unless Phonelist.where(:id => phoneID) == []
        Phonelist.find(phoneID).lists.each { |contact|
        @inboundSMS[contact.member] = contact.msisdn
          }
        end
        }
      end
    end

    def get_outbound_sms
      @outboundSMS ={}
      @policy_id = @policy.id


      @outboundSMSphonelist_ids = []
      @policy.sms_outbound_msisdns.each { |phoneId| 
      @outboundSMSphonelist_ids << phoneId.phonelist_id
        }
      unless @outboundSMSphonelist_ids == nil
        @outboundSMSphonelist_ids.each {|phoneID|
        unless Phonelist.where(:id => phoneID) == []
        Phonelist.find(phoneID).lists.each { |contact|
        @outboundSMS[contact.member] = contact.msisdn
          }
        end
        }
      end
    end

end
