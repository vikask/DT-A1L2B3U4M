#require 'linkedin'
#require 'yaml'
#LINKEDIN_CONFIG = YAML.load_file("#{::Rails.root}/config/linkedin.yml")[::Rails.env]
#LinkedIn.configure do |config|
#  config.token = LINKEDIN_CONFIG["token"]
#  config.secret = LINKEDIN_CONFIG["secret"]
#end