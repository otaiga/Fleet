class Group < ActiveRecord::Base
	belongs_to :account
	has_many :devices, :dependent => :destroy
	belongs_to :policy
	validates :name, :presence => true
end
