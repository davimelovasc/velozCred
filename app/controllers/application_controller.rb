class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken


  def after_sign_in_path_for(resource_or_scope)
    # verificar isChange e redirecionar para uma rota
  end

end
