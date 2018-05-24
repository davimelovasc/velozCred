class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, authentication_keys: [:key_j]
  include DeviseTokenAuth::Concerns::User

  has_one :regional
  belongs_to :regional, optional: true
  has_many :total_productions
  has_one :daily_production


  validates :name, presence: true
  validates :key_j, presence: true, length: {is: 8}
  validates :cpf, presence: true, length: {is: 11}
  validates :role, presence: true
  validates :uf, presence: true
  validates :cost_help, inclusion: { in: [true, false] }

end
