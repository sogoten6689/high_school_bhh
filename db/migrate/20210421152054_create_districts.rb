class CreateDistricts < ActiveRecord::Migration[6.1]
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :code
      t.string :district_slug
      t.references :province_í, null: false, foreign_key: true

      t.timestamps
    end
  end
end
