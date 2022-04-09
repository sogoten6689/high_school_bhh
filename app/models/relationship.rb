class Relationship < ApplicationRecord
    belongs_to :user, dependent: :destroy
end
