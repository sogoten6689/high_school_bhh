class CreateWards < ActiveRecord::Migration[6.1]
  def change
    create_table :wards do |t|
      t.string :name
      t.integer :code
      t.string :ward_slug
      t.integer :district_code
      t.timestamps
    end
  end
end
