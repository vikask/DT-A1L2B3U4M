Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '474151012637938', '40f3ba9405709d8448410191e5ed68ec'
  #provider :facebook, ENV['311175102335078'], ENV['6a349c5c494d0ce43f7c0d2e17fecd77'],
  #         :scope => 'email,user_birthday,read_stream', :display => 'popup'
  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :google_oauth2, '33325605807.apps.googleusercontent.com', '8JTdBLP_y7K4RQO5-yPhwAsA', {
      access_type: 'offline',
      scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
      redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }

end

