Rails.application.routes.draw do
  # MUST be declared before the mount ForestLiana::Engine.
  namespace :forest do
    get '/whoami' => 'admins#whoami'

    post '/actions/mark-as-live' => 'companies#mark_as_live'
    post '/actions/upload-legal-docs' => 'companies#upload_legal_docs'
    post '/actions/charge-credit-card' => 'customers#charge_credit_card'
    post '/actions/generate-invoice' => 'customers#generate_invoice'

    get '/Product/:product_id/buyers' => 'products#buyers'

    get '/LegalDoc' => 'legal_docs#index'
    get '/LegalDoc/:id' => 'legal_docs#show'
    put '/LegalDoc/:id' => 'legal_docs#update'
    delete '/LegalDoc/:id' => 'legal_docs#destroy'

    post '/stats/mrr' => 'charts#mrr'
    post '/stats/credit-card-country-repartition' => 'charts#credit_card_country_repartition'
    post '/stats/charges-per-day' => 'charts#charges_per_day'
  end
  
  mount ForestLiana::Engine => '/forest'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
