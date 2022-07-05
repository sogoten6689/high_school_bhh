class UserContact < ApplicationRecord

  validates :phone_number, format: { with: /(0[3|5|7|8|9])+([0-9]{8})\b/}

  def household_full_address
    @household_province = Province.where(:code => self.household_province).first()
    @household_district = District.where(:code => self.household_district).first()
    @household_ward = Ward.where(:code => self.household_ward).first()

    full_address = []
    full_address.push(self.household_address) unless self.household_address.nil?
    full_address.push(@household_ward.name_with_type) unless @household_ward.nil?
    full_address.push(@household_district.name_with_type) unless @household_district.nil?
    full_address.push(@household_province.name_with_type) unless @household_province.nil?

    return full_address.join(', ') if full_address.size > 0
    return 'Chưa cung cấp'

  end

  def household_address_array
    @household_province = Province.where(:code => self.household_province).first()
    @household_district = District.where(:code => self.household_district).first()
    @household_ward = Ward.where(:code => self.household_ward).first()

    full_address = []
    full_address.push(self.household_address || '')
    full_address.push(@household_ward.nil? ? '' : @household_ward.name_with_type)
    full_address.push(@household_district.nil? ? '' : @household_district.name_with_type)
    full_address.push(@household_province.nil? ? '' : @household_province.name_with_type)

    return full_address

  end

  def contact_full_address
    @contact_province = Province.where(:code => self.contact_province).first()
    @contact_district = District.where(:code => self.contact_district).first()
    @contact_ward = Ward.where(:code => self.contact_ward).first()
    full_address = []

    full_address.push(self.contact_address) unless self.contact_address.nil?
    full_address.push(@contact_ward.name_with_type) unless @contact_ward.nil?
    full_address.push(@contact_district.name_with_type) unless @contact_district.nil?
    full_address.push(@contact_province.name_with_type) unless @contact_province.nil?

    return full_address.join(', ') if full_address.size > 0
    return 'Chưa cung cấp'

  end

  def contact_full_array
    @contact_province = Province.where(:code => self.contact_province).first()
    @contact_district = District.where(:code => self.contact_district).first()
    @contact_ward = Ward.where(:code => self.contact_ward).first()

    full_address = []
    full_address.push(self.contact_address || '')
    full_address.push(@contact_ward.nil? ? '' : @contact_ward.name_with_type)
    full_address.push(@contact_district.nil? ? '' : @contact_district.name_with_type)
    full_address.push(@contact_province.nil? ? '' : @contact_province.name_with_type)

    return full_address

  end

  def show_phone_number

    return self.phone_number unless self.phone_number.nil?
    return 'Chưa cung cấp'
  end

end
