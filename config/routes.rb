Rails.application.routes.draw do

  devise_for :agents, at: 'auth', path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification' }
  #mount_devise_token_auth_for 'Agent', at: 'auth', skip: [:omniauth_callbacks]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :agent do
    get 'login', to: 'devise/sessions#new'
  end

  root  to: 'agent#index'

  get '/index', to: 'agent#index'
  post '/search', to: 'agent#search'

  get '/change_password/:id', to: 'agent#edit', as: 'change_password'
  put '/change_password/:id', to: 'agent#update'

  get '/total_productions', to: 'total_productions#index'

  get '/update_db', to: 'agent#update_db'

end
