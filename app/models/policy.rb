class Policy < ActiveRecord::Base
	belongs_to :account
	has_many :groups
	validates :name, :presence => true
    validates :lock, :inclusion => [true, false]

    has_many :calls_inbound_msisdns, :dependent => :destroy
    accepts_nested_attributes_for :calls_inbound_msisdns, :allow_destroy => true

    has_many :calls_outbound_msisdns, :dependent => :destroy
    accepts_nested_attributes_for :calls_outbound_msisdns, :allow_destroy => true

    has_many :sms_inbound_msisdns, :dependent => :destroy
    accepts_nested_attributes_for :sms_inbound_msisdns, :allow_destroy => true

    has_many :sms_outbound_msisdns, :dependent => :destroy
    accepts_nested_attributes_for :sms_outbound_msisdns,  :allow_destroy => true

    has_many :phonelists
    accepts_nested_attributes_for :phonelists, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

end
