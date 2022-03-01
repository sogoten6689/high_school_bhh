# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
  {
    email:'admin@gmail.com', password: '123456',
    role: 4, full_name: 'Admin', name: 'Admin',
    identification: '123456789', },
  {email:'123456ngoclam@gmail.com', password: '123456',
   role: 1, full_name: 'Nguyen Ngoc Lam', name: 'Lam',
   identification: '426421642'},
]

users.each do |user|
  new_user = User.where(email: user[:email]).first_or_create(user).save(:validate => false)
end

provines = [
    { name: 'HỒ CHÍ MINH', code: 79, province_slug: 'ho_chi_minh',
      # districts: [
      #   { name: 'Quận 1', code: 1, district_slug: 'quan_1',
      #     wards: [
      #       { name: 'Phường 1', code: 1, ward_slug: 'phuong_1'},
      #       { name: 'Phường 2', code: 2, ward_slug: 'phuong_1'}
      #         ]
      #   },
      #   { name: 'Quận 2', code: 2, district_slug: 'quan_2'  },
      # ]
    },
    { name: 'HÀ NỘI', code: 1, province_slug: 'ha_noi' },
]

provines.each do |province|
  new_province = Province.where(code: province[:code]).first_or_create(province)
  # if (provine['districts'])
  #   provine['districts'].each do |district|
  #     province = Province.where(code: province[:code]).first_or_create(province)
  #
  #     end
  #
  #   end

end


districts = [
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

