class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, authentication_keys: [:key_j]
  include DeviseTokenAuth::Concerns::User

  has_one :agent_aux, dependent: :nullify

  validates :name, presence: true
  validates :key_j, presence: true, length: {is: 8}
  validates :cpf, presence: true, length: {is: 11}
  validates :role, presence: true

end
