class Phonelist < ActiveRecord::Base
	belongs_to :account
	has_many :lists, :dependent => :destroy
	accepts_nested_attributes_for :lists, :allow_destroy => true
end
