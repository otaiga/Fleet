class Group < ActiveRecord::Base
	belongs_to :account
	has_many :devices
	validates :name, :presence => true
end
