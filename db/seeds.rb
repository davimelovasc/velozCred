# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

regionals = Regional.create([
  {name: "Fortaleza"},
  {name: "Norte Ceará"},
  {name: "Maranhão"},
  {name: "Parelhas"},
  {name: "Pau dos Ferros"},
  {name: "Sul Ceará"},
  {name: "Matriz"},
  {name: "Piauí"},
  {name: "Mato Grosso"},
  {name: "São Paulo"}
  ])

  #a = Agent.new(name: "Julio Costa", email: "juliocosta@gmail.com", password: "12345678", key_j: "A12345678", cpf: "04443276578", role: "Diretor", uf: "CE", cost_help: false);
  #a.save

#posts = ["Agente", "Assistente", "Gerente", "Supervisor contas"]
