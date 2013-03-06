class Gallery < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :paintings
end
