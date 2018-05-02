CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'xxxxxx',
    google_storage_secret_access_key: 'yyyyyy'
  }
  config.fog_directory = 'name_of_directory'
end

CarrierWave.configure do |config|
  
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end
  
  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
  
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'GOOGMFRX6FJ2MKDKEE4T',
    google_storage_secret_access_key: 'JJyYz0Vz7bD//B5UMX7MWKYM1F8r2xhPlKmNI1H6'
  }
  config.fog_directory = 'rails-youssef'
end
