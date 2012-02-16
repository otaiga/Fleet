class Policy < ActiveRecord::Base
	belongs_to :account
	validates :name, :presence => true
end
