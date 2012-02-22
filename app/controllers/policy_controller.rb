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
      @inboundCalls ={}
      @policy_id = @policy.id

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
      @policy_id = @policy.id


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
      @policy_id = @policy.id


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
      @policy_id = @policy.id


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
