class Group < ActiveRecord::Base
	belongs_to :account
	has_many :devices
	belongs_to :policy
	validates :name, :presence => true
end
