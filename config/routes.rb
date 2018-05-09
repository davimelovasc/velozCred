Rails.application.routes.draw do
  mount_devise_token_auth_for 'Agent', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/edit_password', to: 'agents#edit_password'
  get '/sign_in', to: 'agents#new'

  # devise_scope :agent do
  #   get '/sign_in', to: 'agents#new'
  # end
  #
  # devise_scope :agent do
  #   get '/login', to: 'devise_token_auth/sessions#new'
  # end

end
