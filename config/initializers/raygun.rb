if Rails.env.production?
  Raygun.setup do |config|
    config.api_key = '2pPIRlnnWWOjJVQGo6RNcw=='
    config.filter_parameters = Rails.application.config.filter_parameters
    config.enable_reporting = true
  end
end
