class Policy < ActiveRecord::Base
	belongs_to :account
	has_many :groups
	validates :name, :presence => true
end
