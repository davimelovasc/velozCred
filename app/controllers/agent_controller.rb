class AgentController < ApplicationController
  before_action :set_agent, only: [:edit, :update]
  before_action :require_same_agent, only: [:edit, :update]
  before_action :authenticate_agent!, only: [:edit, :update, :index, :update_db]
  before_action :require_director, only: [:update_db]
  layout :resolve_layout


  def index
    @regionals = Regional.all
    @agents = AgentAux.all
    @segments = Segment.all

    @agents = @agents.order(:name)
    #@posts = Agent.all.posts

    #Temp
    @year_months = ["12/2017", "01/2018", "02/2018", "03/2018", "04/2018", "05/20108"]

    @posts = ["Agente", "Assistente", "Gerente"]
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

  def search
    if params[:commit] == 'Produção Diaria'




    elsif params[:commit] == 'Produção Total'




    end
  end

  def update_db
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

  def require_same_agent
    if current_agent != @agent
      redirect_to index_path
    end
  end

  def require_director
    if current_agent.role == "Diretor" || current_agent.role == "Admin"

      database = Mdb.open("#{Rails.root.to_s}/Cadastro.accdb")
      agents = database["Agentes"]

      agents.each do |a|
        agent = AgentAux.new( account: a[:Conta],
          account_type: a[:TipoConta],
          activity_start: a[:InícioAtividade],
          commission_percent: a[:PercComissão],
          cost_help: a[:AjudaCusto],
          ctps_cda: a[:"CTPS/CDA"],
          discount: a[:Descontos],
          extra: a[:Acrescimos],
          key_j: a[:ChaveJ],
          name: a[:NOME],
          obs: a[:Observação],
          prefix: a[:Prefixo],
          role: a[:CARGO],
          uf: a[:UF],
          vr_comis_account: a[:VrComissãoConta]
        )

        if agent.valid?
          agent.save
        end

      end



      redirect_to index_path


    else
      redirect_to index_path
    end
  end

end
