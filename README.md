Rails version: 5.1.5
Ruby version: 2.5.0 (x86_64-linux)

install mdb:
sudo apt-get install mdbtools

acessar mdb:
database1 = Mdb.open("#{Rails.root.to_s}/Cadastro.accdb")
database2 = Mdb.open("#{Rails.root.to_s}/Producao.accdb")


# list tables in the database
database.tables

# read the records in a table
database[:Movies]
