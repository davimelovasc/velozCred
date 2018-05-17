class AgentController < ApplicationController
  before_action :set_agent, only: [:edit, :update]
  before_action :authenticate_agent!, only: [:edit, :update, :index]
  layout :resolve_layout


  def index
    @regionals = Regional.all
    @agents = Agent.all
    #@posts = Agent.all.posts

    #Temp
    @year_months = ["12/2017", "01/2018", "02/2018", "03/2018", "04/2018", "05/20108"]
    @segments = ["Emprestimo bancário", "Segmento 02", "Segmento 03", "Segmento 04", "Segmento 05"]
    @posts = ["Agente", "Assistente", "Gerente", "Supervisor contas", "Cargo 03", "Cargo 05", "Cargo teste"]
  end

  def edit
  end

  def update
    @agent.is_changed = true
    if @agent.update(agent_params)
      sign_in @agent, :bypass => true
      redirect_to index_path
    else
      @agent.is_changed = false
      render 'edit'
    end
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

  def agent_params
    params.require(:agent).permit(:agent_id, :password)
  end

  def set_agent
    @agent = Agent.find(params[:id])
  end
end
