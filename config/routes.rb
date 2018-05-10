Rails.application.routes.draw do


  devise_for :agents, at: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification' }
  #mount_devise_token_auth_for 'Agent', at: 'auth', skip: [:omniauth_callbacks]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :agent do
    root to: "devise/sessions#new"
    get 'login', to: 'devise/sessions#new'
  end

  get '/edit_password', to: 'agents#edit_password'


  # devise_scope :agent do
  #   get '/sign_in', to: 'agents#new'
  # end
  #
  # devise_scope :agent do
  #   get '/login', to: 'devise_token_auth/sessions#new'
  # end

end
