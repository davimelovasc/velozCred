class AgentController < ApplicationController
  before_action :set_agent, only: [:edit, :update]
  before_action :require_same_agent, only: [:edit, :update]
  before_action :authenticate_agent!
  before_action :require_adm, only: [:update_db]
  layout :resolve_layout


  def index

    if current_agent.role == "Diretor" || current_agent.role == "Adm"
      @agents = AgentAux.all
    elsif current_agent.role == "Gerente"
      aux = AgentAux.where(key_j: current_agent.key_j).last
      @agents = AgentAux.where(regional: aux.regional)
    else
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
      @calendar = Calendar.all
      @daily_productions = DailyProduction.where(agent_aux_id: agents_ids)
    elsif params[:commit] == 'Produção Total'
      @total_productions = TotalProduction.where(agent_aux_id: agents_ids, segment_id: segments_ids, year_month_id: year_months_ids)
    end
  end

  def self.update_db(database1, database2)
    self.update_database(database1, database2)
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

  def self.update_database(database1, database2)

    agentsAcc = database1["Agentes"]
    agents = AgentAux.all

    cont_new = 0;
    cont_upd = 0;

    agentsAcc.each do |a|
      agent = AgentAux.where(key_j: a[:ChaveJ]).last

      if agent != nil # existe no nosso banco


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
        agent.regional_id = regional.id if agent.regional_id != regional.id


        if agent.changed?
          agent = agent.save
          cont_upd += 1
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
          agent = new_agent.save
          cont_new += 1
        end

      end

      if a[:Cpf] != nil && a[:Email] != nil
        agent2 = Agent.where(key_j: agent.key_j).first
        if agent2 == nil #criar
          agent2 = Agent.new(name: agent.name, key_j: agent.key_j,
            email: a[:Email], cpf: a[:Cpf], role: agent.role,
            password: a[:Cpf])

            if agent2.valid?
              agent2.save
            end

          else #update
            agent2.name = agent.name if agent2.name != agent.name
            agent2.role = agent.role if agent2.role != agent.role
            agent2.email = a[:Email] if agent2.email != a[:Email]
            agent2.cpf = a[:Cpf] if agent2.cpf != a[:Cpf]
          end

        end

      end #end loop



      segmentsAcc = database2["Segmentos"]
      cont_new = cont_upd = 0

      segmentsAcc.each do |s|
        segment = Segment.where(segment: s[:Segmentos]).first
        if segment == nil

          seg = Segment.new(segment: s[:Segmentos], ord_segment: s[:OrdSegmento])

          if seg.valid?
            seg.save
            cont_new += 1
          end

        end #end if
      end #end loop

      puts "#{cont_new} segmentos criados"


      year_monthsAcc = database2["AnoMês"]
      cont_new = cont_upd = 0

      year_monthsAcc.each do |y|
        year_month = YearMonth.where(year_month: y[:AnoMes]).first

        if year_month == nil
          ym = YearMonth.new(year_month: y[:AnoMes])

          if ym.valid?
            ym.save
            cont_new += 1
          end

        end #end if
      end #end loop

      puts "#{cont_new} ano/mês criados"

      puts "Atualizando produção diária"

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


          puts 'Transferindo Produção Total'

          total_productions = database2["ProduçãoTotal"]

          total_productions.each do |t|
            agent = AgentAux.where(key_j: t[:"Chave J"]).last
            segment = Segment.where(segment: t[:Segmento]).first
            year_month = YearMonth.where(year_month: t[:AnoMes]).first

            #TODO verificar se nada é nulo
            if agent != nil && segment != nil && year_month != nil
              tp = TotalProduction.where(agent_aux_id: agent.id, segment_id: segment.id, year_month_id: year_month.id)

              if tp == nil

                total_production = TotalProduction.new( production_value: t[:VrProdução],
                  remunaration_percent: t[:PercRemuneração],
                  remuneration: t[:Remuneração] )

                  #TODO PERCREMUNERACAO NAO EXISTE, DE ONDE VEM A META E PERCENTUAL DA META?
                  total_production.agent_aux = AgentAux.where(key_j: t[:"Chave J"]).last
                  total_production.year_month = YearMonth.where(year_month: t[:AnoMes]).first
                  total_production.segment = Segment.where(segment: t[:Segmento]).first

                  if total_production.valid?
                    total_production.save
                    cont_new += 1
                  end
                end  #end if
              end #end if

            end #end loop

            puts "#{cont_new} registros de produções totais adicionadas."


            gerentes = AgentAux.where(role: "Gerente")

            gerentes.each do |g|
              r = g.regional
              r.manager = g
              r.save
            end


            puts "Gerentes das regionais atualizados"
            puts "#{cont_new} agentes criados"
            puts "#{cont_upd} agentes atualizados"


            redirect_to index_path

          end #end method




        end
