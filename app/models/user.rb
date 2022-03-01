class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true
  validates :identification, numericality: { only_integer: true },
            length: { in: 9..12}, allow_blank: true

  # validates :birthday, presence: true


  enum roles: [:undefine, :student, :teacher, :supervisor, :admin]

  after_create do
    UserContact.create([user_id: self.id])
    StudentClass.create([user_id: self.id])
    Relationship.create([user_id: self.id])

  end

end
