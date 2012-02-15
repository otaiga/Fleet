class Device < ActiveRecord::Base
include ActiveModel::Validations
	belongs_to :account
	validates :name, :make, :model, :presence => true
end
