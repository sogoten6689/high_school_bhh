class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true
  # validates :identification, numericality: { only_integer: true },
  #           length: { in: 9..12}, allow_blank: true

  # validates :birthday, presence: true

  has_one :user_contact, dependent: :destroy
  has_one :student_class, dependent: :destroy
  has_one :relationship, dependent: :destroy
  has_one :ethnicities, through: :ethnicity

  enum roles: [:undefine, :student, :teacher, :supervisor, :admin]

  after_create do
    UserContact.create([user_id: self.id])
    # StudentClass.create([user_id: self.id])
    Relationship.create([user_id: self.id])
  end

  def ethnicity_name
    if self.ethnicity == 0
      return self.another_ethnicity
    end
    ethnicity = Ethnicity.where(:code => self.ethnicity).first
    if !ethnicity.nil?
      return ethnicity.name
    else
      return "Chưa có"
    end
  end


  def province_name
    province = Province.where(:code => self.province).first
    if !province.nil?
      return province.name
    else
      return "Chưa có"
    end
  end
end
