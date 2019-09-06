Sidekiq.configure_server do |config|
  config.redis = { url: ENV["URL_REDIS"], namespace: ENV["EVN_REDIS"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["URL_REDIS"], namespace: ENV["EVN_REDIS"] }
end
