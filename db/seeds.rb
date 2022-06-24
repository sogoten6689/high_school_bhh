# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
# users = [
#   {
#     email:'admin@gmail.com', password: '123456',
#     role: 4, full_name: 'Admin', name: 'Admin',
#     identification: '123456789', },
#   {email:'123456ngoclam@gmail.com', password: '123456',
#    role: 1, full_name: 'Nguyen Ngoc Lam', name: 'Lam',
#    identification: '426421642'},
# ]
# users.each do |user|
#   new_user = User.where(email: user[:email]).first_or_create(user).save(:validate => false)
# end
#
# provines = JSON.parse(File.read(Rails.root.join("app/assets/files/city.json")))
# provines.each do |province|
#   province_old = Province.where(:code => province['code']).first
#   if province_old.nil?
#     puts province
#     Province.create(province)
#   end
# end
#
# districts = JSON.parse(File.read(Rails.root.join("app/assets/files/district.json")))
# districts.each do |district|
#   if District.where(code: district['code']).first().nil?
#     puts district
#     District.create(district)
#   end
# end
#
# wards = JSON.parse(File.read(Rails.root.join("app/assets/files/ward.json")))
# wards.each do |ward|
#   if Ward.where(code: ward['code']).first().nil?
#     # puts ward
#     Ward.create(ward)
#   end
# end
#
# ethnicities = JSON.parse(File.read(Rails.root.join("app/assets/files/ethnicity.json")))
# ethnicities.each do |ethnicity|
#   if Ethnicity.where(code: ethnicity['code']).first().nil?
#     puts ethnicity
#     Ethnicity.create(ethnicity)
#   end
# end

# settings = JSON.parse(File.read(Rails.root.join("app/assets/files/setting.json")))
# settings.each do |setting|
#   if Setting.where(key: setting['key']).first().nil?
#     puts setting
#     Setting.create(setting)
#   end
# end

update_cities = JSON.parse(File.read(Rails.root.join("app/assets/files/city_change_code.json")))

update_cities.each do |city|
  # puts city['code']
  # puts city['name']
  if !Province.where("name LIKE ? ", city['name']).first().nil?
    Province.where("name LIKE ? ", city['name']).first().update(change_code: city['code'])
  end
end


update_districts = JSON.parse(File.read(Rails.root.join("app/assets/files/district_change_code2.json")))

update_districts.each do |district|


  province = Province.where(change_code: district['parent_code']).first()

  # puts district['code']
  # puts district['name']
  # puts district['parent_code']
  # puts province['code']

  if !District.where("name_with_type LIKE ? ", district['name']).where(parent_code: province['code']).first().nil?
    # puts "ok";
    District.where("name_with_type LIKE ? ", district['name']).where(parent_code: province['code']).first().update(change_code: district['code'])
  end
end
# District.update(change_code: '')



