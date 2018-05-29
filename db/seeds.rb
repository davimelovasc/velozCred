database1 = Mdb.open("#{Rails.root.to_s}/Cadastro.accdb")
database2 = Mdb.open("#{Rails.root.to_s}/Producao.accdb")

puts 'Transferindo Regionais'

regionals = database2["Regional"]

regionals.each do |r|
  reg = Regional.new(name: r[:NomeRegional], cod_regional: r[:CodRegional])
  if reg.valid?
    reg.save
  end
end

puts 'Transferindo Segmentos'

segments = database2["Segmentos"]

segments.each do |s|
  seg = Segment.new(segment: s[:Segmentos], ord_segment: s[:OrdSegmento])
  if seg.valid?
    seg.save
  end
end

puts 'Transferindo AnoMeses'

year_months = database2["AnoMês"]

year_months.each do |y|
  ym = YearMonth.new(year_month: y[:AnoMes])
  if ym.valid?
    ym.save
  end
end

puts 'Transferindo Agentes'

agentsAux = database1["Agentes"]

agentsAux.each do |a|
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

  agent.regional = Regional.where(cod_regional: a[:CodRegional]).first

  if agent.valid?
    if agent.role == "Gerente"
      r = Regional.where(cod_regional: a[:CodRegional]).first
      r.agent_aux = agent
      r.save
    end
    agent.save
  end
end

puts 'Transferindo Produção Total'

total_productions = database2["ProduçãoTotal"]

total_productions.each do |t|
  total_production = TotalProduction.new( production_value: t[:VrProdução],
    remunaration_percent: t[:PercRemuneração],
    remuneration: t[:Remuneração] )

    #TODO PERCREMUNERACAO NAO EXISTE, DE ONDE VEM A META E PERCENTUAL DA META?
    total_production.agent_aux = AgentAux.where(key_j: t[:"Chave J"]).first
    total_production.year_month = YearMonth.where(year_month: t[:AnoMes]).first
    total_production.segment = Segment.where(segment: t[:Segmento]).first

    if total_production.valid?
      total_production.save
    end
  end

puts 'Transferindo Produção Diária'

  daily_productions = database2["ProduçãoDiária"]
  n = database2["CalendárioCabeçalho"]

  daily_productions.each do |d|
    daily_production = DailyProduction.new( d_one: d[:d01],
      d_two: d[:d02],       d_three: d[:d03],     d_four: d[:d04],    d_five: d[:d05],
      d_six: d[:d06],       d_seven: d[:d07],     d_eight: d[:d08],   d_nine: d[:d09],
      d_ten: d[:d10],       d_eleven: d[:d11],    d_twelve: d[:d12],  d_thirteen: d[:d13],
      d_fourteen: d[:d14],  d_fiveteen: d[:d15],  d_sixteen: d[:d16], d_seventeen: d[:d17],
      d_eighteen: d[:d18],  d_nineteen: d[:d19],  d_twenty: d[:d20],  d_twentyone: d[:d21],
      d_twentytwo: d[:d22], d_twentythree: d[:d23],
      n_one: n[0][:n01],       n_two: n[0][:n02],       n_three: n[0][:n03],   n_four: n[0][:n04],    n_five: n[0][:n05],
      n_six: n[0][:n06],       n_seven: n[0][:n07],     n_eight: n[0][:n08],   n_nine: n[0][:n09],
      n_ten: n[0][:n10],       n_eleven: n[0][:n11],    n_twelve: n[0][:n12],  n_thirteen: n[0][:n13],
      n_fourteen: n[0][:n14],  n_fiveteen: n[0][:n15],  n_sixteen: n[0][:n16], n_seventeen: n[0][:n17],
      n_eighteen: n[0][:n18],  n_nineteen: n[0][:n19],  n_twenty: n[0][:n20],  n_twentyone: n[0][:n21],
      n_twentytwo: n[0][:n22], n_twentythree: n[0][:n23])

      daily_production.agent_aux = AgentAux.where(key_j: d[:"Chave J"]).first

      if daily_production.valid?
        daily_production.save
      end

    end

    a = Agent.new(name: "CLEIDIR ANICETO DE SENA", email: "juliocosta2@gmail.com", password: "12345678", key_j: "J9638258", cpf: "04443276578", role: "Agente")
    b = Agent.new(name: "RAFAEL DE OLIVEIRA COMARU", email: "rafael@gmail.com", password: "12345678", key_j: "J0000002", cpf: "04323165343", role: "Gerente")
    c = Agent.new(name: "Pedro Farias", email: "rafael31@gmail.com", password: "12345678", key_j: "A1234567", cpf: "04443263782", role: "Diretor")


    b.agent_aux = AgentAux.where(key_j: b.key_j).first


    a.save
    b.save
    c.save
