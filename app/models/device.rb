class Device < ActiveRecord::Base
include ActiveModel::Validations
	belongs_to :account
	belongs_to :group
	validates :msisdn, :group_id, :presence => true
end
