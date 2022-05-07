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
end
