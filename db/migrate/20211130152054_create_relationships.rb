class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.string :father_name
      t.integer :father_year
      t.string :father_career
      t.string :father_phone
      t.string :father_address

      t.string :mother_name
      t.integer :mother_year
      t.string :mother_career
      t.string :mother_phone
      t.string :mother_address

      t.string :guardian_name
      t.integer :guardian_year
      t.string :guardian_career
      t.string :guardian_phone
      t.string :guardian_address

      t.string :vietschool_connect_phone

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
