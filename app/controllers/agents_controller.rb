class AgentsController < ApplicationController
  layout :resolve_layout


  def index
  end

  def edit_password
  end

  private

  def resolve_layout
    case action_name
    when "edit_password"
      "forms"
    else
      "application"
    end
  end

end
