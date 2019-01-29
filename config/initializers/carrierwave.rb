# CarrierWave.configure do |config|
#   config.fog_provider = 'fog/aws'
#   config.fog_credentials = {
#     provider:               'AWS',
#     aws_access_key_id:      "#{Rails.application.credentials.aws[:access_key_id]}",
#     aws_secret_access_key:  "#{Rails.application.credentials.aws[:secret_access_key]}",
#     region:                 'eu-west-2'
#   }
#   config.fog_directory  = 'gifti-club'
# end

CarrierWave.configure do |config|
  config.storage    =  :aws                  # required
  config.aws_bucket =  'gifti-club'      # required
  config.aws_acl    =  :public_read

  config.aws_credentials = {
    access_key_id:      "#{Rails.application.credentials.aws[:access_key_id]}",
    secret_access_key:  "#{Rails.application.credentials.aws[:secret_access_key]}",
    region:             'eu-west-2'
  }

  # config.aws_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}",'Expires'=>'Tue, 29 Dec 2015 23:23:23 GMT'}
end
