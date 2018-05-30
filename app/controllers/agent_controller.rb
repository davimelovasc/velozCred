class AgentController < ApplicationController
  before_action :set_agent, only: [:edit, :update]
  before_action :require_same_agent, only: [:edit, :update]
  before_action :authenticate_agent!
  before_action :require_director, only: [:update_db]
  layout :resolve_layout


  def index
    if current_agent.role == "Diretor" || current_agent.role == "Administrador"
      @agents = AgentAux.all
    elsif current_agent.role == "Gerente"
      aux = AgentAux.where(key_j: current_agent.key_j).first
      @agents = AgentAux.where(regional: aux.regional)
    elsif current_agent.role == "Agente"
      @agents = AgentAux.where(key_j: current_agent.key_j)
    end

    @agents = @agents.order(:name)
    @regionals = Regional.all
    @segments = Segment.all
    @year_months = YearMonth.all
    @year_months = @year_months.order(year_month: :desc)
    @roles = AgentAux.select(:role).distinct

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
    agents_ids = params[:agents]
    segments_ids = params[:segments]
    year_months_ids = params[:year_months]

    if params[:commit] == 'Produção Diaria'


    elsif params[:commit] == 'Produção Total'
      @total_productions = TotalProduction.where(agent_aux_id: agents_ids, segment_id: segments_ids, year_month_id: year_months_ids)
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


      database1 = Mdb.open("#{Rails.root.to_s}/Cadastro.accdb")
      database2 = Mdb.open("#{Rails.root.to_s}/Producao.accdb")

      agents = database1["Agentes"]

      agents.each do |a|
        @agent = AgentAux.new( account: a[:Conta],
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

        if AgentAux.where(key_j: @agent.key_j) || Agent.where(key_j: @agent.key_j)
          puts 'Agente existe'
        elsif agent.valid?
          agent.save
        end

      end

      segments = database2["Segmentos"]

      segments.each do |s|
        @segment = Segment.new( segment: s[:Segmentos], ord_segment: s[:OrdSegmento] )

        if Segment.where(segment: @segment.segment)
          puts 'Segmento existe'
        elsif segment.valid?
          segment.save
        end

      end


      total_productions = database2["ProduçãoTotal"]

      # total_productions.each do |t|
      #   @total_production = TotalProduction.new( production_value: t[:VrProdução],
      #     remunaration_percent: t[:PercRemuneração],
      #     remuneration: t[:Remuneração],
      #     year_month: t[:AnoMes])
      #
      #     a = Agent.where(key_j: t[:"Chave J"])
      #
      #     if a != nil
      #       @total_production.agent = a
      #     else
      #       a = AgentAux.where(key_j: t[:"Chave J"]) != null
      #       @total_production << a
      #     end
      #
      #     seg = Segment.where(segment: t[:Segmento])
      #     @total_production << seg
      #
      #
      #
      #     redirect_to index_path
      #
      #   end
      #
      # else
      #   redirect_to index_path
      # end
    end

  end
end
