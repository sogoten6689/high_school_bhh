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
  # has_one :ethnicity, foreign_key: 'code'

  enum roles: [:undefine, :student, :teacher, :teacher_class, :bod, :admin] # supervisor

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

  def religion_name
    if self.religion == 6
      return self.another_religion
    end
    religions = [['Không', 0], ['Công Giáo', 1],['Phật Giáo', 2], ['Hòa Hảo', 3],['Tin Lành', 4], ['Hồi Giáo', 5], ['Khác', 6]]

    religion = religions.select {|religion| religion[1] == self.religion}.first

    if !religion.nil?
      return religion[0]
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

  def last_class_name
    student_class = StudentClass.where(:user_id => self.id).order(created_at: :desc).first
    if !student_class.nil?
      return student_class.class_name
    else
      return "Chưa có"
    end
  end

  def last_class
    student_class = StudentClass.where(:user_id => self.id).order(created_at: :desc).first
    if !student_class.nil?
      return student_class
    else
      return nil
    end
  end
end
