Raven.configure do |config|
  config.dsn = 'https://35dfdeae1ad44d1698fe0218b8f1f5e3:077d0416a4c84dab89f58a2161b5d9cb@sentry.io/1382169'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = ['staging', 'production']
end
