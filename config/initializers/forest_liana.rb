ForestLiana.env_secret = Rails.application.secrets.forest_env_secret
ForestLiana.auth_secret = Rails.application.secrets.forest_auth_secret

ForestLiana.integrations = {
  stripe: {
    api_key: ENV['STRIPE_SECRET_KEY'],
    mapping: 'Customer.stripe_id'
  },
  mixpanel: {
    api_key: ENV['MIXPANEL_API_KEY'],
    api_secret: ENV['MIXPANEL_API_SECRET'],
    mapping: ['Customer.email'],
    custom_properties: ['Campaign Source', 'plan', 'tutorial complete'],
  }
}


