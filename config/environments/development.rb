Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  # Might want to look into database caching, per Horace
  config.action_controller.perform_caching = true
  config.cache_store = :dalli_store
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true

  config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['AWS_BUCKET'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    :region => "us-west-1"
  }
}

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
