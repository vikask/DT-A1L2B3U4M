class Gallery < ActiveRecord::Base
  attr_accessible :cover, :description, :name, :user_id

  has_many :pictures, :dependent => :destroy
  belongs_to :users
end
