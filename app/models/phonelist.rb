class Phonelist < ActiveRecord::Base
	belongs_to :account
	belongs_to :calls_inbound_msisdn
	has_many :lists, :dependent => :destroy
	accepts_nested_attributes_for :lists, :allow_destroy => true
end
