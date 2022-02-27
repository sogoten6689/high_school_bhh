class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, uniqueness: true
  validates :identification, presence: true, uniqueness: true

  enum roles: [:undefine, :student, :teacher, :supervisor, :admin]
end
