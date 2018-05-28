# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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



  if agent.valid?
    agent = agent.save
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

  daily_productions = database2["ProduçãoDiária"]

  # daily_productions.each do |d|
  #   daily_production = DailyProduction.new(d_one: d[:d01],
  #     d_two: d[:d02], d_three: d[:d03], d_four: d[:d04], d_five: d[:d05],
  #     d_six: d[:d06], d_seven: d[:d07], d_eight[:d08])
  #   end

  a = Agent.new(name: "CLEIDIR ANICETO DE SENA", email: "juliocosta@gmail.com", password: "12345678", key_j: "J9638258", cpf: "04443276578", role: "Agente");
  b = Agent.new(name: "RAFAEL DE OLIVEIRA COMARU", email: "rafael@gmail.com", password: "12345678", key_j: "J0000002", cpf: "0432316534", role: "Gerente");
  c = Agent.new(name: "Pedro Farias", email: "rafael@gmail.com", password: "12345678", key_j: "A12345678", cpf: "04443263782", role: "Diretor");


  b.agent_aux = AgentAux.where(key_j: b.key_j).first


  a.save
  b.save
  c.save
