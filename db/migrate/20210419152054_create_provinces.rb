class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :slug
      t.string :type_name
      t.string :name_with_type
      t.integer :code
      t.integer :change_code
      t.timestamps
    end
  end
end
