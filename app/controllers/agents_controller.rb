class AgentsController < ApplicationController
  before_action :set_agent, only: [:edit, :update]
  before_action :require_same_agent, only: [:edit, :update]
  before_action :authenticate_agent!
  before_action :require_adm, only: [:update_db]
  layout :resolve_layout


  def index

    if current_agent.role == "Gestor" || current_agent.role == "Adm"
      @agents = AgentAux.all
      @regionals = Regional.all
      @roles = AgentAux.select(:role).distinct
      @roles = @roles.order(:role)
    elsif current_agent.role == "Gerente"
      aux = AgentAux.where(key_j: current_agent.key_j).last
      @agents = AgentAux.where(regional: aux.regional)
    else
      @agents = AgentAux.where(key_j: current_agent.key_j)
    end

    @agents = @agents.order(:name)
    @segments = Segment.all
    @year_months = YearMonth.all
    @year_months = @year_months.order(year_month: :desc)


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
      @calendar = Calendar.first.attributes.select {|key, val| val != nil }.except("id", "created_at", "updated_at")

      Regional.all.each do |r|
        if agents_ids.include?((r.manager.id).to_s)
          reg = AgentAux.where(name: r.name.upcase, role: 'Regional').last
          if not reg.nil?
            agents_ids = agents_ids.push(reg.id)
          end
        end
      end

      @daily_productions = DailyProduction.where(agent_aux_id: agents_ids)

    elsif params[:commit] == 'Produção Total'
      @total_productions = TotalProduction.where(agent_aux_id: agents_ids, segment_id: segments_ids, year_month_id: year_months_ids)
    end
  end

  def self.update_db(database1, database2, year_months, update_tp)
    self.update_database(database1, database2, year_months, update_tp)
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

  def require_adm
    if current_agent.role == "Adm"
    else
      redirect_to root_path
    end
  end

  def self.update_database(database1, database2, year_months_param, update_tp)


    regionals = database1["Regional"]

    regionals.each do |r|

      reg = Regional.where(cod_regional: r[:CodRegional]).first
      if reg.blank?
        reg = Regional.new(name: r[:NomeRegional], cod_regional: r[:CodRegional])
        if reg.valid?
          reg.save
        end
      else
        reg.name = r[:NomeRegional] if reg.name != r[:NomeRegional]
        if reg.changed?
          reg.save
        end

      end

    end

    agentsAcc = database1["Agentes"]


    agentsAcc.each do |a|
      agent = AgentAux.where(key_j: a[:ChaveJ]).last

      if agent != nil # existe no nosso banco. Atualiza


        regional = Regional.where(cod_regional: a[:CodRegional]).first

        agent.account = a[:Conta] if agent.account != a[:Conta]
        agent.account_type = a[:TipoConta] if agent.account_type != a[:TipoConta]
        agent.activity_start = a[:InícioAtividade] if agent.activity_start != a[:InícioAtividade]
        agent.commission_percent = (a[:PercComissão]).to_f if agent.commission_percent != (a[:PercComissão]).to_f
        agent.cost_help = a[:AjudaCusto] if agent.cost_help != a[:AjudaCusto]
        agent.ctps_cda = a[:"CTPS/CDA"] if agent.ctps_cda != a[:"CTPS/CDA"]
        agent.discount = (a[:Descontos]).to_f if agent.discount != (a[:Descontos]).to_f
        agent.extra = (a[:Acréscimos]).to_f if agent.extra != (a[:Acréscimos]).to_f
        agent.name = a[:NOME] if agent.name != a[:NOME]
        agent.obs = a[:Observação] if agent.obs != a[:Observação]
        agent.prefix = a[:Prefixo] if agent.prefix != a[:Prefixo]
        agent.role = a[:CARGO] if agent.role != a[:CARGO]
        agent.uf = a[:UF] if agent.uf != a[:UF]
        agent.vr_comis_account = (a[:VrComissãoConta]).to_f if agent.vr_comis_account != (a[:VrComissãoConta]).to_f

        if not regional.nil?
          agent.regional_id = regional.id if agent.regional_id != regional.id
        end


        if agent.changed?
          agent.save
        end

      else # nao existe no banco
        new_agent = AgentAux.new( account: a[:Conta],
          account_type: a[:TipoConta],
          activity_start: a[:InícioAtividade],
          commission_percent: a[:PercComissão],
          cost_help: a[:AjudaCusto],
          ctps_cda: a[:"CTPS/CDA"],
          discount: a[:Descontos],
          extra: a[:Acréscimos],
          key_j: a[:ChaveJ],
          name: a[:NOME],
          obs: a[:Observação],
          prefix: a[:Prefixo],
          role: a[:CARGO],
          uf: a[:UF],
          vr_comis_account: a[:VrComissãoConta]
        )

        new_agent.regional = Regional.where(cod_regional: a[:CodRegional]).first

        if new_agent.valid?
          new_agent.save
        end

      end

      if a[:CPF] != nil && a[:EMAIL] != nil
        agent2 = Agent.where(key_j: a[:ChaveJ]).first
        if agent2 == nil # Nao tem login ainda. Cria
          agent2 = Agent.new(name: a[:NOME], key_j: a[:ChaveJ],
            email: a[:EMAIL], cpf: a[:CPF], role: a[:CARGO],
            password: a[:CPF])

            if agent2.valid?
              agent2.save
            end

          else # Tem login. Atualiza
            agent2.name = agent.name if agent2.name != agent.name
            agent2.role = agent.role if agent2.role != agent.role
            agent2.email = a[:Email] if agent2.email != a[:EMAIL]
            agent2.cpf = a[:Cpf] if agent2.cpf != a[:CPF]

            if agent2.changed?
              agent2.save
            end

          end

        end

      end #end loop



      segmentsAcc = database2["Segmentos"]

      segmentsAcc.each do |s|
        segment = Segment.where(cod_segment: s[:CodSegmento]).first
        if segment == nil

          seg = Segment.new(segment: s[:Segmentos], cod_segment: s[:CodSegmento])

          if seg.valid?
            seg.save
          end

        else
          segment.segment =  s[:Segmentos] if segment.segment !=  s[:Segmentos]

          if segment.changed?
            segment.save
          end

        end #end if

      end #end loop


      year_monthsAcc = database2["AnoMês"]

      year_monthsAcc.each do |y|
        year_month = YearMonth.where(year_month: y[:AnoMes]).first

        if year_month == nil
          ym = YearMonth.new(year_month: y[:AnoMes])
          if ym.valid?
            ym.save
          end

        end #end if
      end #end loop

      DailyProduction.delete_all

      daily_productions = database2["ProduçãoDiária"]

      daily_productions.each do |d|
        daily_production = DailyProduction.new( d_one: d[:d01],
          d_two: d[:d02],       d_three: d[:d03],     d_four: d[:d04],    d_five: d[:d05],
          d_six: d[:d06],       d_seven: d[:d07],     d_eight: d[:d08],   d_nine: d[:d09],
          d_ten: d[:d10],       d_eleven: d[:d11],    d_twelve: d[:d12],  d_thirteen: d[:d13],
          d_fourteen: d[:d14],  d_fiveteen: d[:d15],  d_sixteen: d[:d16], d_seventeen: d[:d17],
          d_eighteen: d[:d18],  d_nineteen: d[:d19],  d_twenty: d[:d20],  d_twentyone: d[:d21],
          d_twentytwo: d[:d22], d_twentythree: d[:d23])

          daily_production.agent_aux = AgentAux.where(key_j: d[:"Chave J"]).last

          if daily_production.valid?
            daily_production.save
          end

        end #end loop

        n = database2["CalendárioCabeçalho"]

        Calendar.delete_all

        calendar = Calendar.new( n_one: n[0][:n01],       n_two: n[0][:n02],       n_three: n[0][:n03],   n_four: n[0][:n04],    n_five: n[0][:n05],
          n_six: n[0][:n06],       n_seven: n[0][:n07],     n_eight: n[0][:n08],   n_nine: n[0][:n09],
          n_ten: n[0][:n10],       n_eleven: n[0][:n11],    n_twelve: n[0][:n12],  n_thirteen: n[0][:n13],
          n_fourteen: n[0][:n14],  n_fiveteen: n[0][:n15],  n_sixteen: n[0][:n16], n_seventeen: n[0][:n17],
          n_eighteen: n[0][:n18],  n_nineteen: n[0][:n19],  n_twenty: n[0][:n20],  n_twentyone: n[0][:n21],
          n_twentytwo: n[0][:n22], n_twentythree: n[0][:n23] )

          if calendar.valid?
            calendar.save
          end

          total_productions = database2["ProduçãoTotal"]

          year_months = YearMonth.where(year_month: year_months_param)

          if not year_months.blank? # exclui e recadastra as TP nos meses selecionados

            TotalProduction.where(year_month_id: year_months).destroy_all
            tps = total_productions.select {|tp|  year_months_param.include?(tp[:AnoMes]) }

            tps.each do |t|

              total_production = TotalProduction.new( production_value: t[:VrProdução],
                goal_percent: t[:AtingPerc],
                remuneration: t[:Remuneração],
                remunaration_percent: t[:PercRem])


                total_production.agent_aux = AgentAux.where(key_j: t[:"Chave J"]).last
                total_production.year_month = YearMonth.where(year_month: t[:AnoMes]).first
                total_production.segment = Segment.where(segment: t[:Segmento]).first

                if total_production.valid?
                  total_production.save
                end

              end
            end

            if update_tp == "true" # verifica se existem novas

              total_productions.each do |t|

                agent = AgentAux.where(key_j: t[:"Chave J"]).last
                segment = Segment.where(segment: t[:Segmento]).first
                year_month = TotalProduction.where(year_month_id: t[:AnoMes]).first

                if agent != nil && segment != nil && year_month != nil
                  tp = TotalProduction.where(agent_aux_id: agent.id, segment_id: segment.id, year_month_id: year_month.id).first

                  if tp == nil # cria

                    total_production = TotalProduction.new( production_value: t[:VrProdução],
                      goal_percent: t[:AtingPerc],
                      remuneration: t[:Remuneração],
                      remunaration_percent: t[:PercRem])

                      total_production.agent_aux = AgentAux.where(key_j: t[:"Chave J"]).last
                      total_production.year_month = YearMonth.where(year_month: t[:AnoMes]).first
                      total_production.segment = Segment.where(segment: t[:Segmento]).first

                      if total_production.valid?
                        total_production.save
                      end

                    end

                  end

                end

              end

              gerentes = AgentAux.where(role: "Gerente")

              gerentes.each do |g|
                r = g.regional
                r.manager = g
                r.save
              end

            end #end method




          end
