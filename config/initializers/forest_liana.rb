ForestLiana.env_secret = Rails.application.secrets.forest_env_secret
ForestLiana.auth_secret = Rails.application.secrets.forest_auth_secret

ForestLiana.integrations = {
  stripe: {
    api_key: ENV['STRIPE_SECRET_KEY'],
    mapping: 'Customer.stripe_id'
  },
  mixpanel: {
    api_key: 'b6195a0e1324007c9d596bc70d15d3a5',
    api_secret: 'cf8e1c69f540f109318d16aea2afea10',
    mapping: ['Customer.email', 'Company.name'],
    custom_properties: ['Campaign Source', 'plan', 'tutorial complete'],
  }
}


