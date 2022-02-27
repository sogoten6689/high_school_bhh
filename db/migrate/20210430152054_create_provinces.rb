class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.integer :code
      t.string :province_slug
      t.timestamps
    end
  end
end
