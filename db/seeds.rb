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
    { name: 'HỒ CHÍ MINH', code: 79, province_slug: 'ho_chi_minh', },
    { name: 'HÀ NỘI', code: 1, province_slug: 'ha_noi' },
]

provines.each do |province|
  new_province = Province.where(code: province[:code]).first_or_create(province)

end

districts = [
  { name: 'Bình Tân', code: 1, district_slug: 'binh_tan', province_code: 79 },
  { name: 'Tân Phú', code: 2, district_slug: 'tan_phu', province_code: 79 },
  { name: 'Thanh Xuân', code: 3, district_slug: 'thanh_xuan', province_code: 1 },
  { name: 'Cầu Giấy', code: 4, district_slug: 'cau_giay', province_code: 1 },
]
districts.each do |district|
  new_district = District.where(code: district[:code]).first_or_create(district)
end

wards = [
  { name: 'Bình Hưng Hoà A', code: 1, ward_slug: 'binh_hung_hoa_a', district_code: 1 },
  { name: 'Vĩnh Lộc', code: 2, ward_slug: 'vinh_loc', district_code: 1 },
  { name: 'Hàng Bồ', code: 3, ward_slug: 'hang_bo', district_code: 3 },
  { name: 'Hàng Bạc', code: 4, ward_slug: 'hang_bac', district_code: 3 },
]
wards.each do |ward|
  new_ward = Ward.where(code: ward[:code]).first_or_create(ward)
end

ethnicities = [
  { name: 'Khác', code: 0, ethnicity_slug: 'khac' },
  { name: 'Kinh', code: 1, ethnicity_slug: 'kinh' },
  { name: 'Tày', code: 2, ethnicity_slug: 'tay' },
]

ethnicities.each do |ethnicity|
  Ethnicity.where(code: ethnicity[:code]).first_or_create(ethnicity)
end

