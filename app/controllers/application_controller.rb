class ApplicationController < ActionController::Base
  #include DeviseTokenAuth::Concerns::SetUserByToken
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    if resource.is_changed?
      root_path
    else
      change_password_path(resource.id)
    end

    # verificar isChange e redirecionar para uma rota
  end

  protected

  def layout_by_resource
    if devise_controller? && resource_name == :agent
      "forms"
    else
      "application"
    end

  end

end
