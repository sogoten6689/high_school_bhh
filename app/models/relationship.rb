class Relationship < ApplicationRecord
    belongs_to :user, dependent: :destroy

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
