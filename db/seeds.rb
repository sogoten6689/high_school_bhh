# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
  {email:'admin@gmail.com', password: '123456', role: 4, full_name: 'Admin', identification: '123456789'},
]

users.each do |user|
  User.where(email: user[:email]).first_or_create(user)
end

provines = [
    { name: 'HỒ CHÍ MINH', code: 79, province_slug: 'ho_chi_minh' },
    { name: 'HÀ NỘI', code: 1, province_slug: 'ha_noi' },
]

provines.each do |province|
  Province.where(code: province[:code]).first_or_create(province)
end

ethnicities = [
  { name: 'Khác', code: 0, ethnicity_slug: 'khac' },
  { name: 'Kinh', code: 1, ethnicity_slug: 'kinh' },
  { name: 'Tày', code: 2, ethnicity_slug: 'tay' },
]

ethnicities.each do |ethnicity|
  Ethnicity.where(code: ethnicity[:code]).first_or_create(ethnicity)
end

