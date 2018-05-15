Rails.application.routes.draw do

  get '/index', to: 'agent#index'

  devise_for :agents, at: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification' }
  #mount_devise_token_auth_for 'Agent', at: 'auth', skip: [:omniauth_callbacks]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :agent do
    root to: "devise/sessions#new"
    get 'login', to: 'devise/sessions#new'
  end

  get '/change_password', to: 'agent#edit'
  put '/change_password', to: 'agent#update'

end
