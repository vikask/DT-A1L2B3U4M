class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :user_id, :secret
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

  def twitter
    @twitter ||= Twitter::Client.new(oauth_token: token, oauth_token_secret: secret )
  end

  def facebook
    @facebook ||= FbGraph::User.me(token)
  end

  def google
    require 'google/api_client'
    # Initialize the client & Google+ API
    @google = Google::APIClient.new
    plus = @google.discovered_api('plus')
    # Initialize OAuth 2.0 client
    @google.authorization.client_id = Rails.configuration.client_id
    @google.authorization.client_secret = Rails.configuration.client_secret
    @google.authorization.redirect_uri = Rails.configuration.redirect_uri
    @google.authorization.scope = 'https://www.googleapis.com/auth/plus.me'
    # Request authorization
    redirect_uri = @google.authorization.authorization_uri
    @google.authorization.token = token

  end

  def linkedin
    @linkedin = LinkedIn::Client.new
    @linkedin.authorize_from_access(token, secret)
    return @linkedin
  end
end
