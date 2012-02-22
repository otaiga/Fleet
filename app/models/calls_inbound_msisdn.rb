class CallsInboundMsisdn < ActiveRecord::Base
  belongs_to :policy
  has_many :phonelists
  accepts_nested_attributes_for :phonelists, :allow_destroy => true
end
