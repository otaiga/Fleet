class Device < ActiveRecord::Base
include ActiveModel::Validations
	belongs_to :account
	belongs_to :group
	validates :name, :make, :model, :group_id, :presence => true
end
