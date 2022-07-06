class Relationship < ApplicationRecord
    belongs_to :user, dependent: :destroy

    validates :father_phone, format: { with: /(0[3|5|7|8|9])+([0-9]{8})\b/}, if: -> { father_phone.present? }
    validates :mother_phone, format: { with: /(0[3|5|7|8|9])+([0-9]{8})\b/}, if: -> { mother_phone.present? }
    validates :guardian_phone, format: { with: /(0[3|5|7|8|9])+([0-9]{8})\b/}, if: -> { guardian_phone.present? }
    validates :vietschool_connect_phone, format: { with: /(0[3|5|7|8|9])+([0-9]{8})\b/}, if: -> { vietschool_connect_phone.present? }


    def isAnotherVietSchoolPhoneNumber
        if self.vietschool_connect_phone == self.father_phone
            return false
        end

        if self.vietschool_connect_phone == self.mother_phone
            return false
        end

        return true
    end

    def difficult_area_name
        difficult_code_string = ''
        if self.difficult_code?
            difficult_code_string += " - Sổ sổ hộ nghèo: " + self.difficult_code
        end
        case self.difficult_area
        when 0
            return "Không"
        when 1
            return "Hộ cận nghèo" + difficult_code_string
        when 2
            return "Hộ nghèo " + difficult_code_string
        else
            return "Chưa nhập"
        end
    end


    def difficult_area_name_export
        case self.difficult_area
        when 0
            return "Không"
        when 1
            return "Hộ cận nghèo"
        when 2
            return "Hộ nghèo "
        else
            return "Chưa nhập"
        end
    end
end
