class Policy < ActiveRecord::Base
	belongs_to :account
	has_many :groups
	validates :name, :presence => true
    has_many :calls_inbound_msisdns, :dependent => :destroy
    accepts_nested_attributes_for :calls_inbound_msisdns, :reject_if => lambda { |a| a[:msisdn].blank? }, :allow_destroy => true
end
