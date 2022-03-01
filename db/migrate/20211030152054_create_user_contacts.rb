class CreateUserContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_contacts do |t|
      t.integer :household_province
      t.integer :household_district
      t.integer :household_ward
      t.string :household_address

      t.integer :contact_province
      t.integer :contact_district
      t.integer :contact_ward
      t.string :contact_address

      t.string :phone_number

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
