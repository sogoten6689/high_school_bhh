class UserContact < ApplicationRecord

  def household_full_address
    @household_province = Province.where(:code => self.household_province).first()
    @household_district = District.where(:code => self.household_district).first()
    @household_ward = Ward.where(:code => self.household_ward).first()

    full_address = []
    full_address.push(self.household_address) unless self.household_address.nil?
    full_address.push(@household_ward.name) unless @household_ward.nil?
    full_address.push(@household_district.name) unless @household_district.nil?
    full_address.push(@household_province.name) unless @household_province.nil?

    return full_address.size if full_address.size > 0
    return "Chưa cung cấp"

  end

  def contact_full_address
    @contact_province = Province.where(:code => self.contact_province).first()
    @contact_district = District.where(:code => self.contact_district).first()
    @contact_ward = Ward.where(:code => self.contact_ward).first()
    full_address = []

    full_address.push(self.contact_address) unless self.contact_address.nil?
    full_address.push(@contact_ward.name) unless @contact_ward.nil?
    full_address.push(@contact_district.name) unless @contact_district.nil?
    full_address.push(@contact_province.name) unless @contact_province.nil?

    return full_address.size if full_address.size > 0
    return "Chưa cung cấp"

  end

  def show_phone_number

    return self.phone_number unless self.phone_number.nil?
    return "Chưa cung cấp"
  end

end
