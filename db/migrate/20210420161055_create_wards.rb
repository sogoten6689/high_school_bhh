class CreateWards < ActiveRecord::Migration[6.1]
  def change
    create_table :wards do |t|
      t.string :name
      t.string :slug
      t.string :type_name
      t.string :name_with_type
      t.string :path
      t.string :path_with_type
      t.integer :code
      t.integer :parent_code
      t.integer :change_code
      t.timestamps
    end
  end
end
