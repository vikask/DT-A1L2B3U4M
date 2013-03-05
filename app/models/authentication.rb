  class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :user_id
  belongs_to :user

  validates_uniqueness_of :uid, :scope => :provider

  def provider_name
    if provider == 'open_id'
      "Open_ID"
    elsif provider == 'google_oauth2'
     "Google"
    else
      provider.titleize
    end
  end
end
