class AgentController < ApplicationController
  layout :resolve_layout

  def index
    @regionals = Regional.all
    @agents = Agent.all
  end

  def edit
    @agent = Agent.first
  end

  def update
  end

  private

  def resolve_layout
    case action_name
    when "edit"
      "forms"
    else
      "application"
    end
  end

end
